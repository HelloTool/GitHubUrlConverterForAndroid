
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
---@param compareFunc func(any,any,string) 比较函数，比较两表是否相同。path是路径
---@param path string 深度，用于比较表
---@vararg table
---@return table
function mergeTables(target,compareFunc,path,...)
  local original={...}
  for i=1,#original do
    for key,value in pairs(original[i])
      local isKeyNumber=type(key)=="number"
      local isValueTable=type(value)=="table"
      local needInsert=isKeyNumber
      local replaceKey=key
      local newValue
      if isKeyNumber then--如果键是数字的话，说明当前目标是列表，所以就需要查找一下相同的值
        if compareFunc then
          for i=1,#target do
            if target[i] and type(target[i])==type(value) then
              if compareFunc(target[i],value,path) then
                newValue=target[i]
                needInsert=false
                replaceKey=i
                break
              end
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
