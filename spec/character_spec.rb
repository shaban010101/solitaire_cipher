require 'spec_helper'

describe Encryptor do
  let(:character) { Encryptor.new(:message => "Code in Ruby, live longer!") }

  it "discards non a to z characters" do
    character.discard_non_a_z_charecters
    character.message.should == "CodeinRubylivelonger"
  end

  it "upcases the message" do
    character.uppercase
    character.message.should == "CODE IN RUBY, LIVE LONGER!"
  end

  xit "splits the message into groups of 5" do
    character.split_message
    character.message.should == ["Codei","nRuby","live,","longe","r!XXX"]
  end

  it "converts letter into numbers" do
    character.discard_non_a_z_charecters
    character.uppercase
    character.convert_to_numbers(character.message)
    character.message.should == [3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18]
  end

  it "adds message numbers to keystream" do
    character.message = [ 3, 15, 4 ]
    character.keystream = [ 13, 14, 5 ]
    character.add_message_numbers_keystream_numbers
    character.cipher_text.should == [16, 29, 9 ]
  end
end