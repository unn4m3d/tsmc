require 'digest'

# UUID convertation methods
module UuidHelper
  def raw_md5(string)
    d = Digest::MD5.new
    d << string
    d.digest
  end

  def change_order(bytes)
    bytes.to_s.reverse
  end

  def username_to_uuid(uname)
    raw_d = raw_md5('OfflinePlayer' + uname).unpack('LS2C8')

    t_lo, t_mi, t_hi, cs_hi, cs_lo = raw_d

    cs_hi &= 0x3F
    cs_hi |= (1 << 7)

    if [1].pack('I') != [1].pack('N')
      puts 'Changing order'
      t_lo = change_order t_lo
      t_mi = change_order t_mi
      t_hi = change_order t_hi
    end

    sprintf(
      '%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x',
      (t_lo.to_i & 0xFFFFFFFF), t_mi, t_hi, cs_hi, cs_lo, *(raw_d[5..-1])
    )
  end
end
