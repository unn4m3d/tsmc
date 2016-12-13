require 'digest'

module ApiHelper

  def file_info(root,path)
    {
      name: path.sub(root,""),
      size: size = File.size(path),
      sha256: Digest::SHA256.file(path).hexdigest,
      sha512: Digest::SHA512.file(path).hexdigest
    }
  end

  def gen_sid(usr)
    Digest::SHA512.hexdigest(usr+Time.now.to_s)
  end
end
