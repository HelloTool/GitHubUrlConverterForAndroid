---@class ResGetterHolder
local _M={}
_M._VERSION="1.0 (alpha4)"
_M._VERSIONCODE=1004
_M._NAME="Android Res Getter"
_M._rClass=R
_M._styleCacheMap={}--与 R 类绑定的样式的缓存，储存 res(xxx)
_M._typeCacheMap={}--与样式绑定的类型的缓存，储存 res.xxx

local rCacheMap={}--R 类的缓存，储存 res
rCacheMap[R]=_M

---默认值
---@type table<string,any>
local defaultAttrValues={
  color=0xFFFF0000,
  id=0,
  resourceId=0,
  boolean=false,
  dimension=0,
  dimensionPixelSize=0,
  dimensionPixelOffset=0,
  dimen=0,
  float=0,
  int=0,
  integer=0,
  themeAttributeId=0,
}

---@type table<string,boolean>
local noDefaultAttrValues={
  colorStateList=true,
  complexColor=true,
  drawable=true,
  font=true,
  string=true,
  text=true,
  textArray=true,
  type=true,
  xml=true,
}

---将键转换为java的方法名称
---@type table<string,string>
local key2GetterMap={
  id="getResourceId",
  dimen="getDimension",
  bool="getBoolean",
}

---@type table<string,string>
local key2ResGetterMap={
  int="getInteger",
}

--将键转换为R的键
---@type table<string,string>
local key2RIndexMap={
  colorStateList="color",
  resourceId="id",
  dimension="dimen",
  dimensionPixelSize="dimen",
  dimensionPixelOffset="dimen",
  int="integer",
  boolean="bool",
  text="string",
}

local supportCacheGetterMap={
  getColor=true,
  getInteger=true,
  getBoolean=true,
  getDimension=true,
  getResourceId=true,
  getDimensionPixelSize=true,
  getDimensionPixelOffset=true,
  getFloat=true,
  getInt=true,
  getThemeAttributeId=true
}

local resources=activity.getResources()
local contextTheme=activity.getTheme()

local resMetatable,
androidMetatable,typeMetatable,
androidAttrMetatable,attrMetatable

---将key转换为用于获取TypedArray的方法名
---@param key string 资源类型名称，也就是res.(xxxx)的这段
---@return string methodName 方法名
local function key2Getter(key)
  return key2GetterMap[key] or "get"..string.gsub(key, "^(%w)", string.upper)
end

---将key转换为用于获取Resource的方法名
---@param key string 资源类型名称，也就是res.(xxxx)的这段
---@return string methodName 方法名
local function key2ResGetter(key)
  return key2ResGetterMap[key] or key2Getter(key)
end

---将key转换为R的子类名称
---@param key string 资源类型名称，也就是res.(xxxx)的这段
---@return string rClassName R的子类名
local function key2RIndex(key)
  return key2RIndexMap[key] or key
end

---获取主题中的值
---@param _type string 资源类型名称，也就是res.(xxxx)的这段
---@param key string attr名称，也就是res.xxxx.attr.(xxxx)的这段
---@param style number 主题ID
---@return all value 获取到的值
local function getAttrValue(_type,key,style)
  style=style or 0--主题默认是0
  local array=contextTheme.obtainStyledAttributes(style,{key})
  local getterText=key2Getter(_type)
  local value
  if noDefaultAttrValues[_type] then
    value=array[getterText](0)
   else
    value=array[getterText](0,defaultAttrValues[_type])
  end
  array.recycle()
  luajava.clear(array)
  return value,getterText
end

typeMetatable={
  __index=function(self,key)
    local _type=rawget(self,"_type")
    local style=rawget(self,"_style")
    local rClass=rawget(self,"_rClass")
    local value
    if key=="attr" then--res.xxx.attr
      ---@type ResGetterAttrHolder
      value={_type=_type,_rClass=rClass,_style=style}
      setmetatable(value,attrMetatable)
      rawset(self,key,value)
     else--res.xxx.xxx
      local resGetterText=key2ResGetter(_type)
      ---@type any
      value = resources[resGetterText](rClass[key2RIndex(_type)][key])
      if supportCacheGetterMap[resGetterText] then
        rawset(self,key,value)
      end
    end
    return value
  end,
  __type=function(self)
    return "ResGetterTypeHolder"
  end
}

attrMetatable={
  __index=function(self,key)
    local _type=rawget(self,"_type")
    local style=rawget(self,"_style")
    local rClass=rawget(self,"_rClass")
    local value,getterText=getAttrValue(_type,rClass.attr[key],style)
    if supportCacheGetterMap[getterText] then
      rawset(self,key,value)
    end
    return value
  end,
  __type=function(self)
    return "ResGetterAttrHolder"
  end
}

resMetatable={
  __index=function(self,key)
    local rClass=rawget(self,"_rClass")
    local typeCacheMap=rawget(self,"_typeCacheMap")
    local style=rawget(self,"_style")
    local typed=typeCacheMap[key]
    if not typed then
      ---@type ResGetterTypeHolder
      typed={_type=key,_rClass=rClass,_style=style}
      setmetatable(typed,typeMetatable)
      typeCacheMap[key]=typed
    end
    return typed
  end,
  __call=function(self,styleOrRClass)
    local styleOrRClassType=type(styleOrRClass)
    if styleOrRClassType=="number" then
      return _M.getOrNewResWithStyle(self,styleOrRClass)
     elseif styleOrRClassType=="userdata" then
      return _M.getOrNewResWithRClass(styleOrRClass)
     else
      error("styleOrRClass must be a number or R class.",2)
    end
  end,
  __type=function(self)
    return "ResGetterHolder"
  end
}

---获取或者新建一个指定了样式的 res 对象
---@param style number 样式ID
---@return ResGetterHolder res
function _M:getOrNewResWithStyle(style)
  local rClass=rawget(self,"_rClass")
  local styleCacheMap=rawget(self,"_styleCacheMap")

  local styled=styleCacheMap[style]
  if not styled then
    local typeCacheMap={}
    ---@type ResGetterHolder
    styled={_rClass=rClass,_style=style,_styleCacheMap=styleCacheMap,_typeCacheMap=typeCacheMap}
    setmetatable(styled,resMetatable)
    styleCacheMap[style]=styled
  end
  return styled
end

---获取或者新建一个指定了 R 类的 res 对象
---@param rClass Object R类
---@return ResGetterHolder res
function _M.getOrNewResWithRClass(rClass)
  local className=rClass.getName()
  local setted=rCacheMap[className]
  if not setted then
    local styleCacheMap={}
    local typeCacheMap={}
    ---@type ResGetterHolder
    setted={_rClass=rClass,_styleCacheMap=styleCacheMap,_typeCacheMap=typeCacheMap}
    setmetatable(setted,resMetatable)
    rCacheMap[className]=setted
  end
  return setted
end

---清除缓存，刷新资源。这在配置文件动态修改时候很有用
function _M:clearCache()
  rawset(self,"_styleCacheMap",{})
  rawset(self,"_typeCacheMap",{})
end

---设置支持缓存的 Getter 名称
---@param getterText string Getter 名称
---@param state boolean 是否启用缓存，不会对已缓存的资源生效
function _M.setSupportCacheGetterMap(getterText,state)
  supportCacheGetterMap[getterText]=state
end

setmetatable(_M,resMetatable)

---android.res
---@type ResGetterHolder
android.res=_M.getOrNewResWithRClass(android.R)

return _M