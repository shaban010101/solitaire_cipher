require 'spec_helper'

describe Deck do
  let(:deck) { Deck.new }
  let(:encrypter) { Encryptor.new(:plaintext => "Code in Ruby, live longer!") }

    it "moves joker A down one card" do
    deck.setup_deck 
    deck.move_joker("A", 1)
    deck.cards.index("A").should == 53
  end

  it "moves joker B down" do
    deck.setup_deck
    deck.move_joker("B", 2)
    deck.cards.index("B").should == 1
  end

  it "performs a triple cut" do
    deck.cards = [ 2, 4, 6, "B", 5, 8, 7, 1, "A", 3, 9 ]
    deck.triple_cut
    deck.cards.should == [ 3, 9, "B", 5, 8, 7, 1, "A", 2, 4, 6 ]
  end

  it "performs a count cut" do
    deck.cards = [ 3, 9, "B", 5, 8, 7, 1, "A", 2, 4, 6 ]
    deck.count_cut
    deck.cards.should == [1, "A", 2, 4, 3, 9, "B", 5, 8, 7, 6  ]
  end

  it "produces an output letter" do
    deck.cards = [ 3, 9, "B", 5, 8, 7, 1, "A", 2, 4, 6 ]
    encrypter.plaintext = [ "C","O","D","E","I","N","R","U","B","Y","L"]
    deck.produce_output_cards(encrypter.plaintext)
    deck.keystream.should have(11).items
  end

  it "converts numbers to letters" do
    deck.convert_to_letters(12).should == "L"
  end

  xit "works out the range with last element" do
    deck.workout_order_of_range(-1, 0).should cover(1,-1)
  end
end