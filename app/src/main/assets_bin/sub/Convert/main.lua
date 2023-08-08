package.path=package.path..activity.getLuaPath("../../?.lua;")

require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

import "util.UrlConverter"

import "configs.toolConfigs"
import "configs.converterConfigs"

require "helper"


activity.setContentView(loadlayout("layout"))

local platformConfigs=toolConfigs.platforms

function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
  end
end

loadConverterCustomConfigs(converterConfigs)
loadPlatformCustomConfigs(platformConfigs)


---解析 Intent
---@param intent Intent 要解析的 Intent
function parseIntent(intent,isNewIntent)
  local text
  if intent.getStringExtra(Intent.EXTRA_TEXT) then
    text=intent.getStringExtra(Intent.EXTRA_TEXT)
   elseif intent.getData() then
    local data=intent.getData()
    local scheme=data.getScheme()
    local host=data.getHost()
    if scheme=="http" or scheme=="https" then
      text=tostring(data)
    end
  end
  if not text then
    return
  end

  --直接转换
  local directConvertSucceed=false
  local directConvertedUrlOrMsg
  for i=1,#platformConfigs do
    local platformConfig=platformConfigs[i]
    local directConverterKey=activity.getSharedData(KEY_DIRECT_CONVERT_MACHINE_FORMATTER:format(platformConfig.key))
    if directConverterKey and platformConfig.categories then
      for j=1,#platformConfig.categories do
        local converterkey=platformConfig.categories[j][2]
        if directConverterKey==converterkey then
          local converterConfig=converterConfigs[converterkey]
          directConvertSucceed,directConvertedUrlOrMsg=pcall(convertUrl,text,converterConfig)
        end
        if directConvertSucceed then
          break
        end
      end
      if directConvertSucceed then
        break
      end
    end
  end
  --直接转换成功，自动退出
  if directConvertSucceed then
    openInBrowser(directConvertedUrlOrMsg)
   else
    intent=Intent(activity,Main)
    intent.putExtra(Intent.EXTRA_TEXT,text)
    activity.startActivity(intent)
  end
end

parseIntent(activity.getIntent())
activity.finish()
