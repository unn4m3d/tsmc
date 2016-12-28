require 'digest'
require 'minestat'
require 'aescrypt'

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

  def sha256(str)
    Digest::SHA256.digest str
  end

  def encrypt(s, k)
    iv = sha256(Random.rand(0xFFFFFFFF))[0...16]
    enc = AESCrypt.encrypt_data(s, sha256(k)[0...16], iv, 'AES-128-CBC')
    "#{Base64.encode64 iv}$#{Base64.encode64 enc}"
  end

  def decrypt(s, k)
    iv, msg = s.split('$', 2)
    decoded = Base64.decode64(msg)
    cipher = OpenSSL::Cipher.new('AES-128-CBC')
    cipher.decrypt
    cipher.key = sha256(k)[0...16]
    cipher.iv = Base64.decode64(iv)
    res = cipher.update(decoded)
    res << cipher.final
    res
  end

  def pretty_time(last, current)
    if last.to_date == current.to_date
      current.strftime('%l:%M %p')
    else
      current.strftime('%d %b %l:%M %p')
    end
  end

  def pretty_stats(stats)
    current_time = stats.first.time

    labels = []

    output = {}
    stats.each do |s|
      output[pretty_time(current_time,s.time)] ||= {}
      output[pretty_time(current_time,s.time)][s.server.name] = s
      labels << s.server.name unless labels.include? s.server.name
      current_time = s.time unless s.time == current_time
    end
    return output,labels
  end

  COLORS = [
    { bg: 'rgba(197, 9, 9, 0.2)', border: 'rgba(197, 9, 9, 1)' },
    { bg: 'rgba(7, 112, 160, 0.2)', border: 'rgba(7, 112, 160, 1)' }
  ].freeze
end
