local LuaHelper={}

---设置内容是否可选
---@param dialog Dialog 对话框实例
---@param selectable boolean 是否可选
function LuaHelper.setMessageIsSelectable(dialog,selectable)
  local textView = dialog.findViewById(android.R.id.message)
  textView.setTextIsSelectable(selectable)
end
return LuaHelper
