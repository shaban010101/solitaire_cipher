class Encryptor
  attr_accessor :message, :keystream, :cipher_text
  LETTER = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J","K","L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

  def initialize(attributes = {}) 
    attributes.each do |k, v|
      self.send("#{k}=", "#{v}") if respond_to?("#{k}")
    end
  end

  def discard_non_a_z_charecters
   @message.gsub!(/\W+/,'')
  end

  def uppercase
   @message.upcase!
  end

  def convert_to_numbers(message)
    hash = Hash.new
    msg = []

    LETTER.each_with_index do |letter, index|
      index += 1
      hash.merge!(letter => index)
    end

    message.each_char do |letter|
      msg << hash["#{letter}"]
    end

    @message = msg
  end

  def add_message_numbers_keystream_numbers
    cipher = message.zip(keystream).map { |element| element.inject(&:+) }
    @cipher_text = cipher
  end
end
