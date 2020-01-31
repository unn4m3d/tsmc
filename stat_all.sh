cd $(dirname $0)
source ~/envfile
bundle exec bin/rails runner -e production 'ServerStat.stat_all' >> log/stat_all.log 2>&1
