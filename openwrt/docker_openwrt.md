
# OpenWrt 私有 Docker Registry 快速指南

**（SSD 存储 + Docker data-root 迁移 + htpasswd 认证）**

---

## 一、SSD 挂载（一次性完成）

```sh
vi /etc/config/fstab
```

示例（关键字段）：

```text
config mount
    option target '/mnt/SSD'
    option uuid '<SSD-UUID>'
    option fstype 'ext4'
    option options 'rw,noatime'
    option enabled '1'
```

应用并验证：

```sh
block mount
mount | grep SSD
df -h | grep SSD
```

---

## 二、迁移 Docker data-root 到 SSD

### 1️⃣ 确认当前 Docker 目录

```sh
docker info | grep "Docker Root Dir"
# 通常是 /opt/docker
```

### 2️⃣ 停止 Docker

```sh
/etc/init.d/dockerd stop
ps | grep dockerd
```

### 3️⃣ 拷贝数据到 SSD

```sh
mkdir -p /mnt/SSD/docker
cp -a /opt/docker/* /mnt/SSD/docker/
ls /mnt/SSD/docker
```

### 4️⃣ 修改 Docker 配置

```sh
vi /etc/config/dockerd
```

加入/修改：

```text
config globals 'globals'
    option data_root '/mnt/SSD/docker'
```

### 5️⃣ 启动并验证

```sh
/etc/init.d/dockerd start
docker info | grep "Docker Root Dir"
docker run --rm busybox echo OK
df -h | grep SSD
```

### 6️⃣ 清理旧目录（确认无误后）

```sh
rm -rf /opt/docker/
```

---

## 三、准备 Registry 目录结构

```sh
mkdir -p /mnt/SSD/registry/{data,auth}
```

---

## 四、生成 Registry 认证密码（**推荐方式**）

> **不依赖 opkg**，最稳妥
> 用临时容器生成 **bcrypt htpasswd**

```sh
docker run --rm --entrypoint htpasswd httpd:2 \
  -Bbn docker '你的强密码' > /mnt/SSD/registry/auth/htpasswd

chmod 600 /mnt/SSD/registry/auth/htpasswd
```

验证（不要外泄）：

```sh
cat /mnt/SSD/registry/auth/htpasswd
# docker:$2y$...
```

> 说明
>
> * `-B`：bcrypt（Registry 兼容性最好）
> * 比 `openssl -apr1` 更稳，避免 401 坑

---

## 五、启动 Docker Registry（HTTP，仅内网）

```sh
docker run -d \
  --name registry \
  --restart=always \
  -p 5000:5000 \
  -v /mnt/SSD/registry/data:/var/lib/registry \
  -v /mnt/SSD/registry/auth:/auth:ro \
  -e REGISTRY_AUTH=htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  registry:2
```

验证：

```sh
docker ps
docker logs registry
```

---

## 六、客户端登录（cloudflared 前置 HTTPS）

> **不要带 https://**

```sh
docker login docker-1.liuxr.net
```

测试推拉：

```sh
docker pull busybox
docker tag busybox docker-1.liuxr.net/busybox:test
docker push docker-1.liuxr.net/busybox:test
docker pull docker-1.liuxr.net/busybox:test
```

---

## 七、cloudflared 要点（只记这一句）

```yaml
service: http://127.0.0.1:5000
```

* Registry **只跑 HTTP**
* TLS / 证书 **全部交给 Cloudflare**
* Docker 客户端 **无需 insecure-registries**

---

## 八、强烈建议的“防呆原则”

1. **SSD 未挂载 → 不启动 Registry**
2. Registry / Docker 数据 **永远只写 `/mnt/SSD`**
3. 不在 OpenWrt 上维护 TLS / 证书

---

## 九、最终架构（你现在已经达到）

```text
Docker Client
   ↓ HTTPS
Cloudflare (TLS)
   ↓ cloudflared
HTTP → OpenWrt
   ↓
Docker Registry (registry:2)
   ↓
SSD (/mnt/SSD)
```

这是一个**干净、低耦合、可长期运行**的边缘 Registry 架构。

---

## 十、下一步可选（你已经具备条件）

* Registry → Cloudflare R2（本地无状态）
* Registry 启动前 SSD 守护
* 多 Registry（dev / prod）
* Edge 设备批量拉取优化

如果你愿意，我可以帮你把这份内容 **整理成一页 README.md 或 Wiki 标准文档**，直接能进仓库用。

