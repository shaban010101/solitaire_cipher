require 'spec_helper'

describe Decryptor do
  let(:decryptor) { Decryptor.new("GLNCQMJAFFFVOMBJIYCB", "DWJXHYRFDGTMSHPUURXJ") }

  it "converts the cipher text to numbers" do
    decryptor.convert_cipher_text_to_numbers
    decryptor.cipher_text.should == [7, 12, 14, 3, 17, 13, 10, 1, 6, 6, 6, 22, 15, 13, 2, 10, 9, 25, 3, 2]
  end

  it "converts the keystream to numbers" do
    decryptor.convert_keystream_to_numbers
    decryptor.keystream.should ==  [4, 23, 10, 24, 8, 25, 18, 6, 4, 7, 20, 13, 19, 8, 16, 21, 21, 18, 24, 10]
  end

  it "subtract keystream from cipher text" do
    decryptor.convert_cipher_text_to_numbers
    decryptor.convert_keystream_to_numbers
    decryptor.subtract_keystream_from_cipher_text
    decryptor.plaintext.should == [ 3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18]
  end

  it "converts plaintext numbers back into text" do
    decryptor.plaintext = [ 3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18]
    decryptor.convert_plaintext_back_to_leters
    decryptor.plaintext.should == ["C","O","D","E","I","N","R","U","B","Y","L","I","V","E","L","O","N","G","E","R"]
  end
end