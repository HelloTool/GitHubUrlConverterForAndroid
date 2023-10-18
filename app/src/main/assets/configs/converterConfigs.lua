---转换器配置
---返回一个字典，键：转换器key，唯一标识
---            值：转换器配置
---详情见 UrlConverter

---@type table<string,ConverterConfig>
return {
  kgithub={
    conversionType="domain",
    domain={
      ["github.com"]="kgithub.com",
      ["raw.githubusercontent.com"]="raw.kgithub.com"
    },
    support={
      domains={"github.com","raw.githubusercontent.com"},
    },
    message=[[
网站：<a href="https://kgithub.com/">https://kgithub.com/</a>
<p>
<strong>KGitHub 初衷为帮助学生与开发者群体进行下载加速，请勿滥用</strong>
</p>
<p>
若您发现 Github 上的违法仓库，请给站长发邮件 (kgithub@uoo.im) 进行举报
</p>
<p>
KGitHub 新增<a href="https://gitter.im/kgithub666/community?utm_source=share-link&utm_medium=link&utm_campaign=share-link">聊天室</a>，欢迎各位进来聊天和反馈
</p>
<hr>
<ul>
<li>买广告位吗？>>> <a href="https://help.kgithub.com/ad01">广告位招租</a></li>
<li>前往 KGitHub >>> <a href="https://kgithub.com/">点击进入 KGitHub</a></li>
<li>KGitHub 的 Github 账号 >>>> <a href="https://kgithub.com/kgithub666/kgithub">KGitHub 访问</a>，<a href="https://github.com/kgithub666/kgithub">源站访问</a></li>
<li>各位的捐款可以让KGitHub活得久一些 >>> <a href="https://help.kgithub.com/donate/">捐赠方式</a></li>
<li>查看最新的捐款名单(于 2023.07.27更新) >>> <a href="https://help.kgithub.com/202307/">202307</a> 十分感谢各位的帮助与支持ヾ(≧ ▽ ≦)ゝ</li>
<li>查看一些常见问题 >>> <a href="https://help.kgithub.com/questions/">常见问题</a></li>
</ul>
]],
    supportUrl="https://help.kgithub.com/donate/",
  },
  ghproxy={
    conversionType="formatUrl",
    url="https://ghproxy.com/?q=%s",
    needEncodeUrl=true,
    support={
      domains={"github.com","raw.githubusercontent.com"},
      check={
        --"https?://github.com/.-",
        "https?://github.com/[^/]-",
        "https?://github.com/[^/]+/[^/]+/archive/.+",
        "https?://github.com/[^/]+/[^/]+/releases/download/.+",
        "https?://github.com/[^/]+/[^/]+/blob/.+",
        "https?://raw.githubusercontent.com/[^/]+/[^/]+/.+",
      }
    },
    message=[[
网站：<a href="https://ghproxy.com/">https://ghproxy.com/</a>
<p>
GitHub 文件、Releases、archive、gist、raw.githubusercontent.com 文件代理加速下载服务。
</p>
<p>
如果你有需求同时愿意支持本站，可以通过我的推广链接购买。<br>
</p>
<p>
<strong>特别鸣谢</strong>: 感谢所有<a href="https://ghproxy.com/donate">打赏</a>过的用户，你们的支持将会给本站提供更稳定的服务。
</p>
<h2>终端命令行</h2>
<p>
支持终端命令行 git clone , wget , curl 等工具下载。
</p>
<p>
支持 raw.githubusercontent.com , gist.github.com , gist.githubusercontent.com 文件下载。
</p>
<p>
<strong>注意</strong>：不支持 SSH Key 方式 git clone 下载。<br>
<strong>注意</strong>：以下示例摘自官网，但是经过我测试并不能正常使用。此渠道的链接格式为 https://xxx.xxx/?q=%s ，并非常见的 https://xxx.xxx/%s<br>
</p>
<h3>git clone</h3>
git clone <span style="color:#F44336">https://ghproxy.com/</span><span style="color:#4CAF50">https://github.com/stilleshan/ServerStatus</span>

<h3>git clone 私有仓库</h3>
Clone 私有仓库需要用户在 Personal access tokens 申请 Token 配合使用.<br>
git clone <span style="color:#F44336">https://</span>user:your_token@<span style="color:#F44336">ghproxy.com/</span><span style="color:#4CAF50">https://github.com/your_name/your_private_repo</span>

<h3>wget & curl</h3>

wget <span style="color:#F44336">https://ghproxy.com/</span><span style="color:#4CAF50">https://github.com/stilleshan/ServerStatus/archive/master.zip</span><br>
wget <span style="color:#F44336">https://ghproxy.com/</span><span style="color:#4CAF50">https://raw.githubusercontent.com/stilleshan/ServerStatus/master/Dockerfile</span><br>
curl -O <span style="color:#F44336">https://ghproxy.com/</span><span style="color:#4CAF50">https://github.com/stilleshan/ServerStatus/archive/master.zip</span><br>
curl -O <span style="color:#F44336">https://ghproxy.com/</span><span style="color:#4CAF50">https://raw.githubusercontent.com/stilleshan/ServerStatus/master/Dockerfile</span>

<h2>首页下载</h2>
在本页地址栏输入合规链接（参考以下链接）点击下载按钮<br>
支持 raw.githubusercontent.com , gist.github.com , gist.githubusercontent.com 文件下载。

<h3>Raw 文件</h3>
https://raw.githubusercontent.com/stilleshan/ServerStatus/master/Dockerfile

<h3>分支源码</h3>
https://github.com/stilleshan/ServerStatus/archive/master.zip

<h3>Releases 源码</h3>
https://github.com/stilleshan/ServerStatus/archive/v1.0.tar.gz

<h3>Releases 文件</h3>
https://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_linux_amd64.tar.gz
<div style="text-align:center">
©ghproxy.com. All rights reserved.<br>
Github Project: <a href="https://github.com/hunshcn/gh-proxy">hunshcn/gh-proxy</a>
</div>
]],
    supportUrl="https://ghproxy.com/donate"
  },
  ghsb250gq={
    conversionType="formatUrl",
    url="https://gh.sb250.gq/%s",
    needEncodeUrl=false,
    support={
      domains={"github.com"},
      check={"https?://github.com/.-"}
    },
    message=[[
维护者：<a href="https://5050net.cn/">5050net</a><br>
网站：<a href="https://gh.sb250.gq/">https://gh.sb250.gq/</a><br>
<h2>如何使用？</h2>
将 GitHub 的链接粘贴到上方输入框内。生成代理后的链接可用于 直接下载 和 Git Clone。
此外，如果你要代理的内容受支持，你可以直接在 URL 的前面加上 https://gh.sb250.gq 以使用。

<h2>支持代理哪些内容？</h2>
基于 HTTPS 协议的 Git Clone、Repository 中的文件（也就是 RAW）、Archive & Releases & Gist 的文件、Blob & Suites。
<div style="text-align:center">
Copyright © 2023 PMNET All rights reserved.<br>
Backend by <a href="https://github.com/hunshcn/gh-proxy">hunshcn/gh-proxy</a> | Maintained by <a href="https://5050net.cn/">5050net</a>
</div>
]],

  },
  gh99988866={
    conversionType="formatUrl",
    url="https://gh.api.99988866.xyz/%s",
    needEncodeUrl=false,
    support={
      domains={"github.com"},
      check={
        "https?://github.com/.-",
        "https?://github.com/[^/]-",
        "https?://github.com/[^/]+/[^/]+/archive/.+",
        "https?://github.com/[^/]+/[^/]+/releases/download/.+",
        "https?://github.com/[^/]+/[^/]+/blob/.+",
      },
    },
    message=[[
<p>
开发者：<a href="https://github.com/hunshcn">@hunshcn</a><br>
网站：<a href="https://gh.api.99988866.xyz/">https://gh.api.99988866.xyz/</a><br>
</p>
<p>
<span style="color:#f44336"><strong>演示站为公共服务，如有大规模使用需求请自行部署，演示站有点不堪重负</strong></span>
</p>
<p>
GitHub 文件链接带不带协议头都可以，支持 release、archive 以及文件，右键复制出来的链接都是符合标准的。<br><br>
release、archive 使用 cf 加速，文件会跳转至 JsDelivr。<br><br>
注意，不支持项目文件夹。
</p>
<h2>提示</h2>
<p>
GitHub文件链接带不带协议头都可以，支持release、archive以及文件，右键复制出来的链接都是符合标准的，更多用法、clone加速请参考<a href="https://hunsh.net/archives/23/">这篇文章</a>。
</p>
<p>
release、archive使用cf加速，文件会跳转至JsDelivr
</p>
<p>
<strong>注意</strong>：不支持项目文件夹。
</p>
<h2>合法输入示例</h2>
<ul>
<li>分支源码：https://github.com/hunshcn/project/archive/master.zip</li>
<li>release源码：https://github.com/hunshcn/project/archive/v0.1.0.tar.gz</li>
<li>release文件：https://github.com/hunshcn/project/releases/download/v0.1.0/example.zip</li>
<li>分支文件：https://github.com/hunshcn/project/blob/master/filename</li>
</ul>]],
    supportUrl="https://github.com/hunshcn/gh-proxy#%E6%8D%90%E8%B5%A0"
  },
  moeyy={
    conversionType="formatUrl",
    url="https://github.moeyy.xyz/%s",
    needEncodeUrl=false,
    support={
      domains={"github.com","raw.githubusercontent.com"},
      check={
        "https?://github.com/.-",
        "https?://github.com/[^/]-",
        "https?://github.com/[^/]+/[^/]+/archive/.+",
        "https?://github.com/[^/]+/[^/]+/releases/download/.+",
        "https?://github.com/[^/]+/[^/]+/blob/.+",
        "https?://raw.githubusercontent.com/[^/]+/[^/]+/.+",
      },
    },
    message=[[
<p>
开发者：<a href="https://moeyy.cn/about/">@Moeyy</a><br>
网站：<a href="https://moeyy.cn/gh-proxy/">https://moeyy.cn/gh-proxy/</a>
</p>
<h2>提示</h2>
GitHub 文件链接带不带协议头都可以，支持 release、archive 以及文件，右键复制出来的链接都是符合标准的。
<p>
<strong>注意</strong>：不支持项目文件夹，请使用 Git。
</p>
<h2>合法输入示例</h2>
<ul>
<li>分支源码：https://github.moeyy.xyz/https://github.com/moeyy/project/archive/master.zip</li>
<li>release源码：https://github.moeyy.xyz/https://github.com/moeyy/project/archive/v0.1.0.tar.gz</li>
<li>release文件：https://github.moeyy.xyz/https://github.com/moeyy/project/releases/download/v0.1.0/example.zip</li>
<li>分支文件：https://github.moeyy.xyz/https://github.com/moeyy/project/blob/master/filename</li>
<li>Raw：https://github.moeyy.xyz/https://raw.githubusercontent.com/moeyy/project/archive/master.zip</li>
<li>使用Git: git clone https://github.moeyy.xyz/https://github.com/moeyy/project</li>
</ul>
]],
    supportUrl="https://github.moeyy.cn/donate.html",
  },
  mintimate={
    conversionType="formatUrl",
    url="https://gh.flyinbug.top/gh/%s",
    needEncodeUrl=false,
    support={
      domains={"github.com"},
      check={
        "https?://github.com/.-",
        "https?://github.com/[^/]+/[^/]+/archive/.+",
        "https?://github.com/[^/]+/[^/]+/releases/download/.+",
        "https?://github.com/[^/]+/[^/]+/blob/.+",
      },
    },
    message=[[
<p>
开发者：<a href="https://www.mintimate.cn/about/">@Mintimate</a><br>
网站：<a href="https://tool.mintimate.cn/gh">https://tool.mintimate.cn/gh</a>
</p>
<h2>加速模式</h2>
<ul>
<li>Git仓库克隆：如果链接判断为Git仓库的克隆地址（HTTPS），那么点击 下载/克隆 按钮为克隆模式，即-> 复制 git clone $URL 到剪贴板，其中 $URL 为加速后的Git仓库克隆地址。</li>
<li>文件下载模式：如果链接判断为GitHub上文件、发布文件，那么点击/ 下载/克隆 按钮，会在新标签页进行加速下载。具体支持的文件见下文。</li>
</ul>

<h2>文件下载模式</h2>
支持的文件地址（ release、archive 以及文件，右键复制出来的链接都是符合标准的）：
<ul>
<li>分支源码：https://github.com/Mintimate/h5ai_M/ archive/master.zip</li>
<li>release源码：https://github.com/Mintimate/h5ai_M/ archive/v0.1.0.tar.gz</li>
<li>release文件：https://github.com/Mintimate/h5ai_M/ releases/download/v0.1.0/example.zip</li>
<li>分支文件：https://github.com/Mintimate/h5ai_M/ blob/master/filename</li>
<li>所有文件会使用 Cloudfare 加速 跳转。 文件会跳转至 JSDelivr ，Git 会进行重定向，重定向到 Fastgit.org</li>
</ul>
注意：公共免费资源，请合理、适度使用(*≧ω≦)。

<div style="text-align:center">
基于MIT协议开源项目：<a href="https://github.com/Mintimate/gh-proxy">https://github.com/Mintimate/gh-proxy</a><br>
©2021~2023 Mintimate
</div>
]],
    supportUrl="https://afdian.net/a/mintimate"
  },
  lzzzmai={
    conversionType="formatUrl",
    url="https://git.lzzz.fun/%s",
    needEncodeUrl=false,
    support={
      domains={"github.com"},
      check={
        "https?://github.com/.-",
        "https?://github.com/[^/]-",
        "https?://github.com/[^/]+/[^/]+/archive/.+",
        "https?://github.com/[^/]+/[^/]+/releases/download/.+",
        "https?://github.com/[^/]+/[^/]+/blob/.+",
      },
    },
    message=[[
<p>
开发者：<a href="https://lzzz.fun/">@Lzzzmai</a><br>
网站：<a href="https://git.lzzz.fun/">https://git.lzzz.fun/</a><br>
</p>
<h2>提示</h2>
<p>
GitHub文件链接带不带协议头都可以，支持release、archive以及文件，右键复制出来的链接都是符合标准的，更多用法、clone加速请参考<a href="https://hunsh.net/archives/23/">这篇文章</a>。
</p>
<p>
release、archive使用cf加速，文件会跳转至JsDelivr
</p>
<p>
<strong>注意</strong>：不支持项目文件夹。
</p>
<h2>合法输入示例</h2>
<ul>
<li>分支源码：https://github.com/hunshcn/project/archive/master.zip</li>
<li>release源码：https://github.com/hunshcn/project/archive/v0.1.0.tar.gz</li>
<li>release文件：https://github.com/hunshcn/project/releases/download/v0.1.0/example.zip</li>
<li>分支文件：https://github.com/hunshcn/project/blob/master/filename</li>
</ul>]],
  },
  jsdelivr={
    conversionType="function",
    convertFunction=function(self,url)
      local organization,repository,path=url:match("https?://github.com/([^/]+)/([^/]+)/(.+)")
      return ("https://cdn.jsdelivr.net/gh/%s/%s@%s"):format(organization,repository,path)
    end,
    support={
      domains={"github.com"},
      check={
        "https?://github.com/[^/]+/[^/]+/.+",
      },
    },
    message=[[
<strong>注</strong>：此渠道可能无法使用。如遇无法使用，请尝试更换其他转换器。
<h1>从 GitHub 迁移到 jsDelivr</h1>
jsDelivr 是一款免费、快速、可靠的 npm 和 GitHub 开源 CDN。大多数 GitHub 链接都可以很容易地转换为 jsDelivr 链接。
<p>
<strong>jsDelivr 是一个免费的 CDN（内容交付网络）</strong>
</p>
<p>
<strong>对于开放源文件</strong>
</p>
<p>
通过使用 jsDelivr CDN URL，您可以在全球范围内获得更好的性能，这要归功于我们的多 CDN 基础架构。
</p>
<p>
我们还永久缓存所有文件，以确保可靠性，即使您的文件从 Github 中被删除，它们也将继续在 jsDelivr 上工作，而不会破坏任何使用它们的站点。
</p>
<p>
jsDelivr CDN 专为生产使用而设计，具有多层故障切换，以确保最佳的正常运行时间。
</p>
]],
    supportUrl="https://www.jsdelivr.com/sponsors",
  }
}