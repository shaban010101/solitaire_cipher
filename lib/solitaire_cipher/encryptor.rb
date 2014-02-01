class Encryptor
  attr_accessor :message
  LETTER = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J","K","L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

  def initialize(message)
    @message = message
    @cards = []
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
end
