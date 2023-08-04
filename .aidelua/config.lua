--- 工具属性
tool={
  version="1.1",
}
appName="Github链接转换"--应用名称
packageName="io.gitee.jesse205.github.urlconverter"--应用包名
debugActivity="com.androlua.LuaActivity"--运行Lua的Activity
key = "JXNB" --运行Lua时传入的key，用于校验

include={"project:app","project:androlua"}--导入，第一个为主程序
compileLua=false--编译Lua，nil为跟随全局
alignZip = nil --优化APK，nil为跟随全局

---图标
---相对路径位于工程根目录下
icon={
  day="app/src/main/ic_launcher-playstore.png",--图标
  night="app/src/main/ic_launcher_night-playstore.png",--暗色模式图标
}