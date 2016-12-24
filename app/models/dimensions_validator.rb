# Validator for dimensions
class DimensionsValidator < ActiveModel::EachValidator
  def validate_each(rec, attr, val)
    dimensions = Paperclip::Geometry.from_file(
      val.queued_for_write[:original].path
    )
    options[:dimensions].each do |d|
      return if d[:width] == dimensions.width && d[:height] == dimensions.height
    end
    rec.errors[attr] << "Wrong size : #{dimensions.width}x#{dimensions.height}"
  end
end
