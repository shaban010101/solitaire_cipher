module Conversion
  CHARACTER = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J","K","L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

  def convert_to_letters(number)
    character = Hash.new

    CHARACTER.each_with_index do |letter, index|
      index += 1
      character.merge!(index => letter)
    end
    character[number]
  end

  def convert_to_numbers(character)
    number = Hash.new

    CHARACTER.each_with_index do |letter, index|
      index += 1
      number.merge!(letter => index)
    end
    number[character]
  end
end