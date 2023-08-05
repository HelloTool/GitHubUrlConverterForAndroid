# 使用文档

## 转换链接

软件内内置了 GitHub 平台，您可以直接使用 GitHub 链接转换的功能。

1. 选择 GitHub 平台。软件内默认只有 GitHub 平台，会不会显示标签栏，且默认选中该平台。
2. 将 GitHub 文件链接（比如发行版）填入输入框内。
  * 可以复制 GitHub 链接，然后粘贴进输入框。
  * 也可以直接从 GitHub APP 分享链接到此应用。搭配 F-Droid 应用商店使用效果更佳。
  * 需要注意的是，高版本安卓拥有 url 校验，目前可能无法在高版本安卓使用打开浏览器的方式打开此软件。
2. 选择您喜欢的一个转换器，推荐 `kGitHub`与`GitHub Proxy` 。
3. 加工链接（转换链接）。
  * 点击“开始转换”，然后您可以复制链接到浏览器，或者分享给朋友。
  * 或者点击“转换并打开”，使用浏览器打开链接。
  * 或者点击“转换并分享”，将链接分享给好友。

> 输入框内文字会自动匹配出链接，因此无须担心链接外拥有杂质的问题。

## 自定义平台

软件内默认内置 GitHub 平台。如果您还需要转换其他平台的链接（如：GitLab），您可以添加自定义的平台。

1. 下载文件编辑器，或者带有编辑功能的文件管理器。（如：[质感文件](https://github.com/zhanghai/MaterialFiles/releases/latest)、[MT 管理器](https://mt2.cn/)）。
2. 进入软件，点击 `溢出菜单 > 设置... > 编辑平台配置` 。
3. 选择刚刚安装的文件管理或者编辑器，编辑文件内容。

文件大致内容：

``` json
[
    {
        "name": "GitHub",
        "key": "github",
        "categories": [
            [
                "kGitHub",
                "kgithub"
            ],
            [
                "GitHub 文件加速 (演示)",
                "gh99988866"
            ]
        ]
    }
]
```

4. 在根列表内仿照以上格式，添加一个新的平台，比如添加一个 GitLab：

```json
[
    {
        "name": "GitHub",
        "key": "github",
        "categories": [
            [
                "kGitHub",
                "kgithub"
            ],
            [
                "GitHub 文件加速 (演示)",
                "gh99988866"
            ]
        ]
    }
    {
        "name": "GitLab",
        "key": "gitlab",
        "categories": [
            [
                "转换器1",
                "machine1"
            ],
            [
                "转换器2",
                "machine2"
            ]
        ]
    }
]
```

其中每个平台配置（PlatformConfig）：

- name (string): 平台名称
- key (string): 唯一标识符，用于区分不同的平台
- categories (string[][]): 转换器分类
  - \[1\]: 转换器名称，用于显示到UI中
  - \[2\]: 转换器标识符，用于寻找转换器

注意：相同的平台会自动合并，相同的转换器分类也会自动合并。

提示：您可能还需要自定义转换器才能自定义平台。

## 自定义转换器

软件内内置了与 GitHub 有关的转换器。如果您还需要转换其他平台的链接（如：GitHub proxy XXX），您可以添加自定义的转换器。

1. 下载文件编辑器，或者带有编辑功能的文件管理器。（如：[质感文件](https://github.com/zhanghai/MaterialFiles/releases/latest)、[MT 管理器](https://mt2.cn/)）。
2. 进入软件，点击 `溢出菜单 > 设置... > 编辑平台配置` 。
3. 选择刚刚安装的文件管理或者编辑器，编辑文件内容。

文件大致内容：

``` json
{
    "kgithub_example": {
        "conversionType": "domain",
        "domain": {
            "raw.githubusercontent.com": "raw.kgithub.com",
            "github.com": "kgithub.com"
        },
        "support": {
            "domains": [
                "github.com",
                "raw.githubusercontent.com"
            ]
        },
        "supportUrl": "https://help.kgithub.com/donate/",
        "message": "网站：<a href=\"https://kgithub.com/\">https://kgithub.com/</a>\n<p>\n<strong>KGitHub 初衷为帮助学生与开发者群体进行下载加速，请勿滥用</strong>\n</p>\n<p>\n若您发现 Github 上的违法仓库，请给站长发邮件 (kgithub@uoo.im) 进行举报\n</p>\n<p>\nKGitHub 新增<a href=\"https://gitter.im/kgithub666/community?utm_source=share-link&utm_medium=link&utm_campaign=share-link\">聊天室</a>，欢迎各位进来聊天和反馈\n</p>\n<hr>\n<ul>\n<li>买广告位吗？>>> <a href=\"https://help.kgithub.com/ad01\">广告位招租</a></li>\n<li>前往 KGitHub >>> <a href=\"https://kgithub.com/\">点击进入 KGitHub</a></li>\n<li>KGitHub 的 Github 账号 >>>> <a href=\"https://kgithub.com/kgithub666/kgithub\">KGitHub 访问</a>，<a href=\"https://github.com/kgithub666/kgithub\">源站访问</a></li>\n<li>各位的捐款可以让KGitHub活得久一些 >>> <a href=\"https://help.kgithub.com/donate/\">捐赠方式</a></li>\n<li>查看最新的捐款名单(于 2023.07.27更新) >>> <a href=\"https://help.kgithub.com/202307/\">202307</a> 十分感谢各位的帮助与支持ヾ(≧ ▽ ≦)ゝ</li>\n<li>查看一些常见问题 >>> <a href=\"https://help.kgithub.com/questions/\">常见问题</a></li>\n</ul>\n"
    },
    "gh99988866_example": {
        "needEncodeUrl": false,
        "conversionType": "formatUrl",
        "support": {
            "check": [
                "https?://github.com/.-",
                "https?://github.com/[^/]-",
                "https?://github.com/[^/]+/[^/]+/archive/.+",
                "https?://github.com/[^/]+/[^/]+/releases/download/.+",
                "https?://github.com/[^/]+/[^/]+/blob/.+"
            ],
            "domains": [
                "github.com"
            ]
        },
        "supportUrl": "https://github.com/hunshcn/gh-proxy#%E6%8D%90%E8%B5%A0",
        "message": "<p>\n开发者：<a href=\"https://github.com/hunshcn\">@hunshcn</a><br>\n网站：<a href=\"https://gh.api.99988866.xyz/\">https://gh.api.99988866.xyz/</a><br>\n</p>\n<p>\n<span style=\"color:#f44336\"><strong>演示站为公共服务，如有大规模使用需求请自行部署，演示站有点不堪重负</strong></span>\n</p>\n<p>\nGitHub 文件链接带不带协议头都可以，支持 release、archive 以及文件，右键复制出来的链接都是符合标准的。<br><br>\nrelease、archive 使用 cf 加速，文件会跳转至 JsDelivr。<br><br>\n注意，不支持项目文件夹。\n</p>\n<h2>提示</h2>\n<p>\nGitHub文件链接带不带协议头都可以，支持release、archive以及文件，右键复制出来的链接都是符合标准的，更多用法、clone加速请参考<a href=\"https://hunsh.net/archives/23/\">这篇文章</a>。\n</p>\n<p>\nrelease、archive使用cf加速，文件会跳转至JsDelivr\n</p>\n<p>\n<strong>注意</strong>：不支持项目文件夹。\n</p>\n<h2>合法输入示例</h2>\n<ul>\n<li>分支源码：https://github.com/hunshcn/project/archive/master.zip</li>\n<li>release源码：https://github.com/hunshcn/project/archive/v0.1.0.tar.gz</li>\n<li>release文件：https://github.com/hunshcn/project/releases/download/v0.1.0/example.zip</li>\n<li>分支文件：https://github.com/hunshcn/project/blob/master/filename</li>\n</ul>",
        "url": "https://gh.api.99988866.xyz/%s"
    },
    "ghproxy_example": {
        "needEncodeUrl": true,
        "conversionType": "formatUrl",
        "support": {
            "check": [
                "https?://github.com/[^/]-",
                "https?://github.com/[^/]+/[^/]+/archive/.+",
                "https?://github.com/[^/]+/[^/]+/releases/download/.+",
                "https?://github.com/[^/]+/[^/]+/blob/.+",
                "https?://raw.githubusercontent.com/[^/]+/[^/]+/.+"
            ],
            "domains": [
                "github.com",
                "raw.githubusercontent.com"
            ]
        },
        "supportUrl": "https://ghproxy.com/donate",
        "message": "网站：<a href=\"https://ghproxy.com/\">https://ghproxy.com/</a>\n<p>\nGitHub 文件、Releases、archive、gist、raw.githubusercontent.com 文件代理加速下载服务。\n</p>\n<p>\n如果你有需求同时愿意支持本站，可以通过我的推广链接购买。<br>\n</p>\n<p>\n<strong>特别鸣谢</strong>: 感谢所有<a href=\"https://ghproxy.com/donate\">打赏</a>过的用户，你们的支持将会给本站提供更稳定的服务。\n</p>\n<h2>终端命令行</h2>\n<p>\n支持终端命令行 git clone , wget , curl 等工具下载。\n</p>\n<p>\n支持 raw.githubusercontent.com , gist.github.com , gist.githubusercontent.com 文件下载。\n</p>\n<p>\n<strong>注意</strong>：不支持 SSH Key 方式 git clone 下载。<br>\n<strong>注意</strong>：以下示例摘自官网，但是经过我测试并不能正常使用。此渠道的链接格式为 https://xxx.xxx/?q=%s ，并非常见的 https://xxx.xxx/%s<br>\n</p>\n<h3>git clone</h3>\ngit clone <span style=\"color:#F44336\">https://ghproxy.com/</span><span style=\"color:#4CAF50\">https://github.com/stilleshan/ServerStatus</span>\n\n<h3>git clone 私有仓库</h3>\nClone 私有仓库需要用户在 Personal access tokens 申请 Token 配合使用.<br>\ngit clone <span style=\"color:#F44336\">https://</span>user:your_token@<span style=\"color:#F44336\">ghproxy.com/</span><span style=\"color:#4CAF50\">https://github.com/your_name/your_private_repo</span>\n\n<h3>wget & curl</h3>\n\nwget <span style=\"color:#F44336\">https://ghproxy.com/</span><span style=\"color:#4CAF50\">https://github.com/stilleshan/ServerStatus/archive/master.zip</span><br>\nwget <span style=\"color:#F44336\">https://ghproxy.com/</span><span style=\"color:#4CAF50\">https://raw.githubusercontent.com/stilleshan/ServerStatus/master/Dockerfile</span><br>\ncurl -O <span style=\"color:#F44336\">https://ghproxy.com/</span><span style=\"color:#4CAF50\">https://github.com/stilleshan/ServerStatus/archive/master.zip</span><br>\ncurl -O <span style=\"color:#F44336\">https://ghproxy.com/</span><span style=\"color:#4CAF50\">https://raw.githubusercontent.com/stilleshan/ServerStatus/master/Dockerfile</span>\n\n<h2>首页下载</h2>\n在本页地址栏输入合规链接（参考以下链接）点击下载按钮<br>\n支持 raw.githubusercontent.com , gist.github.com , gist.githubusercontent.com 文件下载。\n\n<h3>Raw 文件</h3>\nhttps://raw.githubusercontent.com/stilleshan/ServerStatus/master/Dockerfile\n\n<h3>分支源码</h3>\nhttps://github.com/stilleshan/ServerStatus/archive/master.zip\n\n<h3>Releases 源码</h3>\nhttps://github.com/stilleshan/ServerStatus/archive/v1.0.tar.gz\n\n<h3>Releases 文件</h3>\nhttps://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_linux_amd64.tar.gz\n<div style=\"text-align:center\">\n©ghproxy.com. All rights reserved.<br>\nGithub Project: <a href=\"https://github.com/hunshcn/gh-proxy\">hunshcn/gh-proxy</a>\n</div>\n",
        "url": "https://ghproxy.com/?q=%s"
    }
}
```

最外层是一个字典，键为转换器的标识，值为转换器配置。

您可以仿照上面的格式添加更多转换器。

其中每个转换器配置（ConverterConfig）：

- conversionType (string): 转换类型，目前拥有 "domain"、 "formatUrl" 和 "function"。"domain" 为替换域名，"formatUrl" 为格式化内容，"function"为执行函数。
- convertFunction (func(ConverterConfig,string)): 转换类型
- domain (table<string,string>|string|nil): 域名替换，键为被替换的域名 值为替后的域名。仅 conversionType 为"domain" 时生效。
- url (string): 要格式化的字符串，仅拥有一个 %s，且仅在 conversionType 为 "formatUrl" 生效。
- needEncodeUrl (boolean): 格式化 url 时是否需要进行 url 编码，且仅在 conversionType 为 "formatUrl" 生效。
- support (ConverterSupportConfig): 输入内容校验配置
- message (string|nil): 展示的信息，内容为 html 代码
- supportUrl (string|nil): 支持作者的 url

其中校验配置（ConverterSupportCon：

- domains (string[]|nil) 域名列表，仅用户输入的域名在列表内则通过。
- check (string[]|nil) 正则列表，仅用户符合其中一项则通过。
