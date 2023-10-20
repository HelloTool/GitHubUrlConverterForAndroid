---@class PlatformConfig
---@field name string 平台名称，如 "GitHub"
---@field key string 平台标识，如 "github"
---@field categories string[] 转换器分类，1为名词，2为标识

---@class ToolConfigs
---@field platforms PlatformConfig[] 平台列表

---@type ToolConfigs
return {
  platforms={
    {
      name="GitHub",
      key="github",
      categories={
        --{"kGitHub","kgithub"},
        {"jsDelivr","jsdelivr"},
        {"GitHub Proxy","ghproxy"},
        {"GitHub Proxy (mirrors.pw)","ghsb250gq"},
        {"GitHub Proxy (Moeyy)","moeyy"},
        {"GitHub Proxy (Mintimate)","mintimate"},
        {"GitHub Proxy (Lzzzmai)","lzzzmai"},
        {"GitHub 文件加速 (演示)","gh99988866"},
      },
      groups={"github"},
    }
  }
}