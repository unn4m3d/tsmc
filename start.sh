source ~minecraft/envfile
RAILS_ENV=production bundle exec puma -b 'ssl://192.168.1.166:9292?key=/etc/letsencrypt/live/unn4m3d.ddns.net/privkey.pem&cert=/etc/letsencrypt/live/unn4m3d.ddns.net/fullchain.pem' -b 'tcp://192.168.1.166:3000'
