import "android.net.Uri"

---@class ConverterSupportConfig
---@field domains string[]|nil 域名列表，仅用户输入的域名在列表内则通过。
---@field check string[]|nil 正则列表，仅用户符合其中一项则通过。

---@class ConverterConfig
---@field conversionType string 转换类型，目前拥有 "domain"、 "formatUrl" 和 "function"。"domain" 为替换域名，"formatUrl" 为格式化内容，"function"为执行函数。
---@field convertFunction func(ConverterConfig,string) 转换类型
---@field domain table<string,string>|string|nil 域名替换，键为被替换的域名 值为替后的域名。仅 conversionType 为"domain" 时生效。
---@field url string 要格式化的字符串，仅拥有一个 %s，且仅在 conversionType 为 "formatUrl" 生效。
---@field needEncodeUrl boolean 格式化 url 时是否需要进行 url 编码，且仅在 conversionType 为 "formatUrl" 生效。
---@field support ConverterSupportConfig 输入内容校验配置
---@field message string|nil 展示的信息，内容为 html 代码
---@field supportUrl string|nil 支持作者的 url

---@class UrlConverter
---@field _VERSION string 版本名
---@field _VERSION_CODE string 版本号
local UrlConverter={}
UrlConverter._VERSION="1.2"
UrlConverter._VERSION_CODE=1299


---转换链接
---@param originUrl string 原始url
---@param config ConverterSupportConfig 配置文件
---@return url string 转换后的链接
function UrlConverter.convert(originUrl,config)
  local support=config.support
  local domain=originUrl:match("://([%w%p]-):?[%d]-/")
  if support then
    if support.domains then
      assert(table.find(support.domains,domain),"此类转换不支持该域名")
    end
    if support.check then
      local passed=false
      for i=1,#support.check do
        if string.find(originUrl,support.check[i]) then
          passed=true
          break
        end
      end
      assert(passed,"链接检查不通过")
    end
  end
  if config.conversionType=="domain" then
    local newDomain
    if type(config.domain)=="table" then
      newDomain=config.domain[domain]
     else
      newDomain=config.domain
    end
    return originUrl:gsub("://[%w%p]-(:?[%d]-)/","://"..newDomain.."%1/")
   elseif config.conversionType=="formatUrl" then
    return config.url:format(config.needEncodeUrl and Uri.encode(originUrl) or originUrl)
   elseif config.conversionType=="function" then
    return config.convertFunction(config,originUrl)
   else
    error("未知转换类型")
  end
end

return UrlConverter
