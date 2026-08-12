#!/bin/bash
# ═══════════════════════════════════════════════════════════════
#  67guy 服务器部署脚本
#  在 Ubuntu 22.04 上执行: bash deploy.sh
# ═══════════════════════════════════════════════════════════════
set -e

echo "========================================="
echo "  67guy 部署脚本"
echo "========================================="

# ── 1. 更新系统 & 安装依赖 ──────────────────────────────────
echo "[1/6] 更新系统包..."
sudo apt update && sudo apt upgrade -y

echo "[2/6] 安装 Node.js 20.x..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs nginx certbot python3-certbot-nginx

echo "[3/6] 创建应用目录..."
sudo mkdir -p /opt/67guy
sudo chown $USER:$USER /opt/67guy

echo "[4/6] 安装 PM2 进程守护..."
sudo npm install -g pm2

echo "[5/6] 配置 Nginx 反向代理..."
sudo tee /etc/nginx/sites-available/67guy > /dev/null <<'NGINX'
server {
    listen 80;
    server_name YOUR_DOMAIN.com;   # ← 改成你的域名

    client_max_body_size 10m;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # 安全：禁止直接访问数据文件
    location ~* \.(json|bak|tmp)$ {
        return 404;
    }
}
NGINX

sudo ln -sf /etc/nginx/sites-available/67guy /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t && sudo systemctl reload nginx

echo "[6/6] 开启 HTTPS（替换 YOUR_DOMAIN.com 后执行）"
echo "   sudo certbot --nginx -d YOUR_DOMAIN.com"

echo ""
echo "========================================="
echo "  基础环境安装完成！"
echo "  接下来:"
echo "  1. 把项目文件上传到 /opt/67guy/"
echo "  2. cd /opt/67guy && npm install"
echo "  3. pm2 start ecosystem.config.js"
echo "  4. pm2 save && pm2 startup"
echo "========================================="
