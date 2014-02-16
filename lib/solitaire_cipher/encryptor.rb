require_relative "conversion"

class Encryptor
  include Conversion
  attr_accessor :plaintext, :keystream, :cipher_text

  def initialize(attributes = {}) 
    attributes.each do |k, v|
      self.send("#{k}=", "#{v}") if respond_to?("#{k}")
    end
  end

  def discard_non_a_z_charecters
   @plaintext.gsub!(/\W+/,'')
  end

  def uppercase
   @plaintext.upcase!
  end

  def split_into_groups
    str = @plaintext
    str = str % 5 
    str
  end

  def convert_plaintext_to_numbers(plaintext)
    msg = []
    plaintext.each_char do |letter|
      msg << convert_to_numbers("#{letter}")
    end
    
    @plaintext = msg
  end

  def add_plaintext_numbers_keystream_numbers(keystream)
    results = []
    converted_keystream =  []

    keystream.each do |key| 
      character = convert_to_numbers("#{key}")
      converted_keystream <<  character
    end

    converted_keystream.compact!

    plaintext.zip(converted_keystream).each do |element|
     result = element.inject(:+)
     results << result
    end

    @cipher_text = results
  end
end
