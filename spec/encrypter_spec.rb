require 'spec_helper'

describe Encryptor do
  let(:encrypter) { Encryptor.new(:plaintext => "Code in Ruby, live longer!") }
  let(:deck) { Deck.new }

  it "discards non a to z encrypters" do
    encrypter.discard_non_a_z_charecters
    encrypter.plaintext.should == "CodeinRubylivelonger"
  end

  it "upcases the plaintext" do
    encrypter.uppercase
    encrypter.plaintext.should == "CODE IN RUBY, LIVE LONGER!"
  end

  it "splits the plaintext into groups of 5" do
    encrypter.discard_non_a_z_charecters
    encrypter.split_into_groups
    encrypter.plaintext.should == ["Codei","nRuby","livel","onger"]
  end

  it "adds X for groups which have no empy chars" do
    encrypter.discard_non_a_z_charecters
    encrypter.plaintext = "Codei yogi"
    encrypter.split_into_groups
    encrypter.plaintext.should == ["Codei","yogiX"]
  end

  it "converts letter into numbers" do
    encrypter.discard_non_a_z_charecters
    encrypter.uppercase
    encrypter.convert_plaintext_to_numbers(encrypter.plaintext)
    encrypter.plaintext.should == [3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18]
  end

  it "adds plaintext numbers to keystream" do
    encrypter.plaintext = [ 3, 15, 4 ]
    encrypter.keystream = [ 13, 14, 5 ]
    encrypter.add_plaintext_numbers_keystream_numbers(encrypter.keystream)
    encrypter.cipher_text.should == [16, 29, 9 ]
  end

  it "encrypts a plaintext" do
    encrypter.discard_non_a_z_charecters
    encrypter.uppercase
    encrypter.convert_plaintext_to_numbers(encrypter.plaintext)
    deck.setup_deck
    deck.move_joker("A", 1)
    deck.move_joker("B", 2)
    deck.triple_cut
    deck.count_cut
    deck.produce_output_cards(encrypter.plaintext)
    encrypter.keystream = deck.keystream
    encrypter.add_plaintext_numbers_keystream_numbers(encrypter.keystream)
    # encrypter.to_letters
    # encrypter.cipher_text
  end
end