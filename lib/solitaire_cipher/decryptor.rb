require_relative "conversion"

class Decryptor
  include Conversion
  attr_accessor :plaintext, :keystream, :cipher_text

  def initialize(cipher_text, keystream) 
    @cipher_text = cipher_text
    @plaintext = []
    @keystream = keystream
  end

  %w[cipher_text keystream].each do |attribute|
    define_method("convert_#{attribute}_to_numbers") do
      numbers = []

      text = self.send("#{attribute}") 

      text.each_char do |char|
        numbers << convert_to_numbers("#{char}")
      end
      
      self.send("#{attribute}=", numbers)
    end
  end

  def subtract_keystream_from_cipher_text
    keystream.zip(cipher_text).each do |numbers|
      numbers.inject do |key, cipher|

        cipher < key ? cipher = cipher + 26 : cipher
        
        @plaintext << sum = cipher - key
      end
    end
  end

  def convert_plaintext_back_to_leters
    text = []

    @plaintext.each do |number|
      text << convert_to_letters(number)
    end

    @plaintext = text
  end
end