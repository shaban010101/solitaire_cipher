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
    string = @plaintext
    count = string.split(//).count % 5
    remainder = 5 - count
    string = string.scan(/.{1,5}/)

    if count > 0 
      last_element = string.slice(-1)
      string.delete_at(-1)
      padding = "X" * remainder 
      last_element = last_element + padding
      string << last_element
    end
    
    @plaintext = string
  end

  def convert_plaintext_to_numbers(plaintext)
    msg = []
    plaintext.each_char do |letter|
      msg << convert_to_numbers("#{letter}")
    end
    
    @plaintext = msg
  end

  def add_plaintext_numbers_keystream_numbers(keystream)
    sum = []
    converted_keystream =  []

    keystream.each do |key| 
      character = convert_to_numbers("#{key}")
      converted_keystream <<  character
    end

    plaintext.zip(converted_keystream).each do |element|
      element = remove_nils(element)
      sum << element.inject(:+)
    end

    @cipher_text = sum
  end

private 

  def remove_nils(elements)
    elements.collect do |element|
      element.nil? ? 0 : element 
    end
  end
end
