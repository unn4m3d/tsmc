require 'rmagick'
require 'mineskin'

# Helpers
module HomeHelper
  def arm_height(u)
    6 * u / 4
  end

  def leg_height(u)
    arm_height u
  end

  def body_height(u)
    arm_height(u)
  end

  def unit(width)
    width / 8
  end

  def resize_unit(image, src_w, dest_w)
    dest_unit = dest_w / 6
    image.sample(dest_unit / unit(src_w))
  end

  def prettify_skin(path, size)
    if File.exist? path
      puts 'Starting prettifying'
      sd = MineSkin::SkinData.new(path)
      preview = MineSkin::Preview::Skin2D.new(sd)
      image = preview.render(size)
      image.format = 'png'
      puts 'Finished'
      image.to_blob
    else
      nil
    end
  end

  def prettify_cape(path, size)
    if File.exist? path
      puts 'Starting prettifying'
      sd = MineSkin::CapeData.new(path)
      preview = MineSkin::Preview::Cape2D.new(sd)
      image = preview.render(size)
      image.format = 'png'
      puts 'Finished'
      image.to_blob
    else
      nil
    end
  end
end
