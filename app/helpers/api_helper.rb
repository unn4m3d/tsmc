require 'digest'
require 'minestat'

# Useful API helpers
module ApiHelper
  def file_info(root, path)
    {
      name: path.sub(root, ''),
      size: File.size(path),
      sha256: Digest::SHA256.file(path).hexdigest,
      # sha512: Digest::SHA512.file(path).hexdigest
    }
  end

  def gen_sid(usr)
    Digest::SHA512.hexdigest(usr + Time.now.to_s)
  end

  def server_data(serv)
    MineStat.new(serv.ip, serv.port)
  end
end
