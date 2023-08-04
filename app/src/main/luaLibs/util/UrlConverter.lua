import "android.net.Uri"

---@class UrlConverter
---@field _VERSION string 版本名
---@field _VERSION_CODE string 版本号
local UrlConverter={}
UrlConverter._VERSION="1.1"
UrlConverter._VERSION_CODE=1199

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
   elseif config.conversionType=="formatUrl"
    return config.url:format(config.needEncodeUrl and Uri.encode(originUrl) or originUrl)
   else
    error("未知转换类型")
  end
end

return UrlConverter
