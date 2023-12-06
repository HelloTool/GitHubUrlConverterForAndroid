import "android.content.Context"
import "android.content.Intent"
import "android.content.ClipData"
import "android.net.Uri"
import "io.gitee.jesse205.github.urlconverter.BuildConfig"
import "io.gitee.jesse205.github.urlconverter.R"
import "java.io.File"
import "json"

PRJ_PATH=luajava.luadir
--子页面，退出两格就是工程目录
if PRJ_PATH:match("/sub/[^/]+$") then
  PRJ_PATH=PRJ_PATH.."/../.."
end

KEY_DIRECT_CONVERT_MACHINE_FORMATTER="UrlConverter.directConvert.machine.%s"

FILE_CONFIGS_DIR=activity.getExternalFilesDir("config")
PATH_CONFIGS_DIR=FILE_CONFIGS_DIR.getPath()

PATH_PLATFORM_CONFIGS_DEFAULT=PRJ_PATH.."/configs/defaultPlatforms.json"
PATH_PLATFORM_CONFIGS=PATH_CONFIGS_DIR.."/platforms.json"
FILE_PLATFORM_CONFIGS=File(PATH_PLATFORM_CONFIGS)

--TODO: 重命名为 defaultConverters.json
PATH_CONVERTER_CONFIGS_DEFAULT=PRJ_PATH.."/configs/defaultConverter.json"
--TODO: 重命名为 converters.json
PATH_CONVERTER_CONFIGS=PATH_CONFIGS_DIR.."/defaultConverter.json"
FILE_CONVERTER_CONFIGS=File(PATH_CONVERTER_CONFIGS)

---启动浏览器
---@param url string 链接
function openInBrowser(url)
  local intent = Intent(Intent.ACTION_VIEW,Uri.parse(url))
  if intent.resolveActivity(activity.getPackageManager()) then
    activity.startActivity(intent)
   else
    toast("未找到浏览器")
  end
end

---使用第三方软件打开文件
---@param uri Uri 文件 Uri
function openInOtherApp(uri)
  local intent = Intent(Intent.ACTION_VIEW)
  intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION|Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
  intent.setDataAndType(uri, "text/json")
  xpcall(activity.startActivity,function(err)
    toast("未找到文件编辑器："..err:match("(.-)\n"))
  end,intent)
end

---吐司
---@param text string 内容
function toast(text)
  Toast.makeText(activity, text,Toast.LENGTH_SHORT).show()
end

---写入文件
---@param path string 文件路径
---@param content string 文件内容
---@return string errMsg|nil 错误信息
function writeFile(path,content)
  local file,errMsg=io.open(path,"w")
  if not file then
    return errMsg
  end
  _,errMsg=file:write(content)
  file:close()
  if errMsg then
    return errMsg
  end
end

---读取
---@param path string 文件路径
---@return string content|nil 文件内容
---@return string errMsg|nil 错误信息
function readFile(path)
  local file,errMsg=io.open(path,"r")
  if not file then
    return nil,errMsg
  end
  local content,errMsg=file:read("a")
  file:close()
  return content,errMsg
end


---合并表
---@param target table 要合并到的表
---@param compareFunc fun(targetValue: any, originValue: any, path: string):boolean 比较函数，比较两表是否相同。
---@param path string 深度，用于比较表
---@vararg table
---@return table
function mergeTables(target,compareFunc,path,...)
  local original={...}
  for i=1,#original do
    for key,value in pairs(original[i]) do
      local isKeyNumber=type(key)=="number"
      local isValueTable=type(value)=="table"
      local needInsert=isKeyNumber
      local replaceKey=key
      ---@type any
      local newValue
      if isKeyNumber then--如果键是数字的话，说明当前目标是列表，所以就需要查找一下相同的值
        if compareFunc then
          for i=1,#target do
            local isSameTable=target[i] and type(target[i])==type(value) and compareFunc(target[i],value,path)
            if isSameTable then
              newValue=target[i]
              needInsert=false
              replaceKey=i
              break
            end
          end
        end
      end
      
      if isValueTable then
        if isKeyNumber then--如果键是数字的话，说明当前目标是列表，所以就需要查找一下相同的表
          newValue=newValue or {}
         else
          newValue=newValue or target[replaceKey] or {}
        end
        --(isKeyNumber and "{number}" or key)
        mergeTables(newValue,compareFunc,path.."/"..key,value)
       else--不是表，直接覆盖
        newValue=value
      end

      if needInsert then
        table.insert(target,newValue)
       elseif replaceKey then
        target[replaceKey]=newValue
      end
    end
  end
  return target
end

---匹配出url
---@param text string 匹配url
---@return string | nil 匹配出的链接
function matchUrl(text)
  return text:match("(https?://[%w%p]+)")
end

---转换链接
---@return string
function convertUrl(text,converterConfigs)
  local originUrl=matchUrl(text)
  assert(originUrl,"未找到链接")
  local url=UrlConverter.convert(originUrl,converterConfigs)
  return url
end

--[[print(dump(mergeTables({a={},b={}},
function(oldValue,newValue,path)
  if path=="/a" then
    return oldValue==newValue
    end
  print(path)
end,\
"",
{a={"hello"},b={c="world"},d={{3},{2}}},
{a={"world","www","hello"},b={c="hi"},d={{1},{2}}}
)))]]

---加载转换器自定义配置
function loadConverterCustomConfigs(converterConfigs)
  if FILE_CONVERTER_CONFIGS.isDirectory() then
    LuaUtil.rmDir(FILE_CONVERTER_CONFIGS)
  end
  FILE_CONFIGS_DIR.mkdirs()

  local customConverterConfigsJson,errMsg
  if not FILE_CONVERTER_CONFIGS.isFile() then
    LuaUtil.copyFile(PATH_CONVERTER_CONFIGS_DEFAULT,PATH_CONVERTER_CONFIGS)
  end
  customConverterConfigsJson,errMsg=readFile(PATH_CONVERTER_CONFIGS)
  if errMsg then
    toast(errMsg)
    return
  end
  local contentMD5=LuaUtil.getMD5(customConverterConfigsJson)

  local success,customConverterConfig=pcall(json.decode,customConverterConfigsJson)
  if success then
    xpcall(mergeTables,function(errMsg)
      toast("转换器配置文件合并出错："..errMsg)
    end,converterConfigs,nil,"root",customConverterConfig)
   else
    toast("转换器配置文件出错："..customConverterConfig)
  end
  return contentMD5
end

---加载自定义平台配置
function loadPlatformCustomConfigs(platformConfigs)
  if FILE_PLATFORM_CONFIGS.isDirectory() then
    LuaUtil.rmDir(FILE_PLATFORM_CONFIGS)
  end
  FILE_CONFIGS_DIR.mkdirs()

  local customPlatformConfigsJson,errMsg
  if not FILE_PLATFORM_CONFIGS.isFile() then
    LuaUtil.copyFile(PATH_PLATFORM_CONFIGS_DEFAULT,PATH_PLATFORM_CONFIGS)
  end
  customPlatformConfigsJson,errMsg=readFile(PATH_PLATFORM_CONFIGS)
  if errMsg then
    toast(errMsg)
    return
  end
  local contentMD5=LuaUtil.getMD5(customPlatformConfigsJson)

  local success,customPlatformConfigs=pcall(json.decode,customPlatformConfigsJson)
  if success then
    xpcall(mergeTables,function(errMsg)
      toast("平台配置文件合并出错："..errMsg)
      end,platformConfigs,function(oldValue,newValue,path)
      if path=="root" then
        return oldValue.key==newValue.key
       elseif path:match("^root/%d/categories$") then
        return oldValue[2]==newValue[2]
       elseif path:match("^root/%d/categories/%d$") then
        return oldValue==newValue
      end
    end,"root",customPlatformConfigs)
   else
    toast("平台配置文件出错："..customPlatformConfigs)
  end
  return contentMD5
end
