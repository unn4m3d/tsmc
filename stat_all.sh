cd $(dirname $0)
source ~/envfile
cd /home/minecraft/tsmc && bundle exec bin/rails runner -e production 'ServerStat.stat_all' >> log/stat_all.log 2>&1
