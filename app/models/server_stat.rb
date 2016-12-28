class ServerStat < ApplicationRecord
  belongs_to :server

  def self.stat_all
    time = DateTime.now
    Server.all.each do |serv|
      stat = MineStat.new(serv.ip,serv.port)
      puts "#{serv.name} : #{stat.current_players}"
      ServerStat.create(
        online: stat.online,
        players: stat.current_players,
        server: serv,
        time: time
      )
    end
  end
end
