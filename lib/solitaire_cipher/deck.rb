class Deck
  attr_accessor :cards
  CARDS = (1..52)

  def initialize
    @cards = []
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

  def count_cut

  end
end