OVERWALL
===

使用 docker-compose 部署翻墙服务，现在支持：

- v2ray：vmess+tls+ws 模式

## v2ray 配置方法

1. 填写 `.env` 中的配置，比如

```conf
# 域名
VIRTUAL_HOST=v2ray.proxy.com
LETSENCRYPT_HOST=v2ray.proxy.com
# 邮箱
LETSENCRYPT_EMAIL=v2ray@proxy.com
```

2. 配置 v2ray 的配置中 `clients -> id`，为 UUID，默认为 `77cfc806-0278-4bc8-bae4-ff314fc6a44d`。

3. 运行 `sudo ./start.sh` 脚本即可。
