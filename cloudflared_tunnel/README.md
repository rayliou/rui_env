# Cloudflare Tunnel（Remote-managed）+ Published application routes + Browser SSH（GitHub 登录）

> 目标：办公室电脑**不暴露 22**，在家用公网域名访问；并支持 **浏览器 SSH**。
> 本 README 以我们最终成功的方式为准：**云端控制 + 本地只跑连接器**。
> **不写废弃方案**（本地 config.yml、Networks/Hostname routes、WARP 私网模型）。

---

## 0. 总体概念（最终成功模型）

```
Browser
  → Cloudflare Access（GitHub 登录 + Policy）
    → Cloudflare Edge
      → Tunnel（cloudflared 常驻长连接，HTTP2）
        → 本机 sshd:22
```

关键原则：

* ✅ 云端唯一控制面：**Published application routes**
* ✅ 本地只做：**cloudflared 连接器常驻（systemd）**
* ✅ 强制协议：**HTTP2**（绕开 QUIC/UDP 问题）
* ❌ 不用：本地 `config.yml` / ingress
* ❌ 不用：Networks → Hostname routes（会把你带到 WARP/私网那套）
* ✅ **DNS 不手动配**：让 Published application routes 自动创建/绑定需要的 DNS 记录

---

## 1. 安装 cloudflared

安装后确认：

```bash
cloudflared --version
```

---

## 2. 创建 Remote-managed Tunnel，并拿到 token

在 Zero Trust 控制台创建 Tunnel（云端创建），办公室电脑执行控制台给的命令（带 token）：

```bash
cloudflared tunnel run --token <LONG_TOKEN>
```

---

## 3. 强制使用 HTTP2（你这台客户端 UDP/QUIC 不可靠时必做）

### 3.1 安装/启用 systemd 常驻服务

如果提示已安装，先卸载再装：

```bash
sudo cloudflared service uninstall
sudo cloudflared service install
```

### 3.2 修改 systemd ExecStart：加入 `--protocol http2`

把 ExecStart 固化成类似下面（路径以你机器实际为准）：

```ini
ExecStart=/usr/bin/cloudflared --no-autoupdate tunnel --protocol http2 run --token <LONG_TOKEN>
```

然后：

```bash
sudo systemctl daemon-reload
sudo systemctl restart cloudflared
sudo systemctl enable cloudflared
```

---

## 4. 云端路由与 DNS（**自动完成**，不手动配 DNS）

> 这一节替代你指出的“手动 DNS”。我们最终方案里：**不需要你在 DNS 页面手工加记录**。

进入：

```
Zero Trust → Networks → Tunnels → <your tunnel>
```

只用这一块：

* ✅ **Published application routes**（我们用它）
* ❌ Hostname routes（不用）

### 4.1 添加一条 Published application route（SSH）

在 Published application routes 里新增（或 Add route / Add public hostname 类似入口）：

* Hostname：`ssh-b.liuxr.net`
* Type / Service：`SSH`
* Origin：`ssh://localhost:22`（sshd 在本机时）

**重点：**这一步会把该 hostname 与 tunnel 绑定，并且**自动把相关 DNS 记录加到你的域名里**（你无需自己去 DNS 页面创建 CNAME）。

### 4.2 如果你之前“手动配过 DNS”，现在应该删掉

如果你曾经手工加过 `ssh-b.liuxr.net` 的 CNAME/记录，可能会造成：

* 重复记录
* 目标不一致
* 路由/证书表现怪异

做法：

* 去 Cloudflare DNS 页面
* 找到 `ssh-b` 对应记录
* **删除你手动创建的那条**
* 保留由 Published application routes 自动生成/维护的记录

> 你这次的要求是：**有手工 DNS 就删掉**——按这个执行即可。

---

## 5. Access：浏览器渲染 SSH（Application 层）

进入：

```
Zero Trust → Access → Applications → Add an application → Self-hosted
```

### 5.1 Basic information

* Application name：`ssh-b`
* Public hostname：选/填 `ssh-b.liuxr.net`
* 不添加 Private hostname

### 5.2 Browser rendering（必须打开）

在应用设置里：

* ✅ Browser rendering：On（SSH terminal）
* ✅ Allow automatic cloudflared authentication：On（建议保留）

---

## 6. 身份认证：GitHub 最舒服（Integrations / Identity providers）

### 6.1 找 Team name（用于 GitHub 回调）

```
Zero Trust → Settings → Team name / Team domain
```

Team domain 形如：

```
https://<TEAM_NAME>.cloudflareaccess.com
```

### 6.2 GitHub 创建 OAuth App（一次性）

GitHub：

```
Settings → Developer settings → OAuth Apps → New OAuth App
```

关键字段：

* Authorization callback URL：

```
https://<TEAM_NAME>.cloudflareaccess.com/cdn-cgi/access/callback
```

不要勾 Device Flow。

拿到：

* Client ID
* Client Secret

### 6.3 Cloudflare 启用 GitHub IdP

```
Zero Trust → Integrations → Identity providers → GitHub
```

填入 Client ID/Secret 保存。

---

## 7. Access Policy：放行你的 GitHub 身份（否则会被拒绝）

在：

```
Access → Applications → ssh-b → Policies
```

新增一条：

* Action：Allow
* Include：GitHub username（或你的 email）

没有 Allow 就会出现 “That account does not have access”。

---

## 8. 浏览器 SSH 的硬要求：Linux 用户名匹配邮箱前缀

如果 Access 识别到你的 email 是 `lxr@gmail.com`，则服务器必须有用户 `lxr`：

```bash
id lxr || sudo useradd -m -s /bin/bash lxr
```

---

## 9. 验证

浏览器打开：

```
https://ssh-b.liuxr.net
```

期望流程：

1. Access 显示 “Sign in with GitHub”
2. 登录成功
3. 浏览器出现 SSH 终端，连到本机 sshd:22

---

## 10. 我们明确不再使用的东西（避免回到混乱）

* ❌ 本地 `config.yml` / ingress（locally-managed）
* ❌ Networks → Hostname routes（尤其弹 WARP/100.64/10 的那套）
* ❌ Email One-time PIN（不稳定）
* ❌ QUIC/UDP（你的环境不支持时）

