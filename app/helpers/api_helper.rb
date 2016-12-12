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
end
