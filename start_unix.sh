cd $(dirname $0)
source ~minecraft/envfile
RAILS_ENV=production bundle exec puma -b 'unix:///home/minecraft/puma.sock'
