require_relative "conversion"

class Deck
  include Conversion
  attr_accessor :cards, :keystream
  CARDS = (1..52)
  
  def initialize
    @cards = []
    @keystream = []
  end

  def setup_deck
    CARDS.each { |n| @cards << n }
    
    ["A","B"].each do |joker|
      @cards << "#{joker}"
    end
  end

  def move_joker(joker, distance)
    move_by = @cards.index(joker) + distance

    if move_by >= @cards.count
      move_by = move_by - @cards.count
    end 

    @cards.delete_at(@cards.index(joker))
    @cards.insert(move_by,joker)
  end

  def triple_cut
    count = 0
    front = []
    back = []

    index = workout_index_for_jokers

    index.each do |element|
      if count <= 0
        to = element > index.at(1) ? -1 : 0
        range = workout_order_of_range(to, element)
        front = @cards.slice!(range)
        count += 1
      else
        to = element > index.at(0) ? -1 : 0
        range = workout_order_of_range(to, element)
        back = @cards.slice!(range)
        count += 1
      end
    end

    @cards.unshift(front)
    @cards.flatten!
    @cards << back
    @cards.flatten!
  end

  def count_cut
    bottom = @cards.last.is_a?(String) ? 53 : @cards.last

    till = bottom % 13
    take = @cards.slice!(0...till)

    @cards.insert(-2, take)
    @cards.flatten!
  end

  def produce_output_cards(plaintext)
    plaintext.size.times do
      move = @cards.first % 26
      number = @cards[move]
      letter = convert_to_letters(number)
      @keystream << letter
    end
  end

private

  def workout_index_for_jokers
    index = []

    %w[A B].each do |joker|
      index << @cards.index(joker) 
    end
    index
  end

  def workout_order_of_range(to,element)
    if to == -1  
      element + 1..to
    else
      to...element
    end
  end
end