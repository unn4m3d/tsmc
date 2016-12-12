module XorHelper
  def xor(str,key)
    output = ""
    str.chars.each_with_index do |chr,i|
      output << (chr.ord ^ key[i%key.size].ord)
    end
    output
  end
end
