#!/bin/bash
apt-get install python3 -y;
apt-get install python3-pip -y;
pip3 install flask

cd /usr/bin
rm -rf backend
wget -q -O backend "http://red-flat.my.id:6969/script-vpn/backbot"
chmod +x backend
cd
cat >/etc/systemd/system/backend.service << EOF
[Unit]
Description=My Project
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/python3 /usr/bin/backend 0.0.0.0 meki
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart backend
systemctl enable backend

