class Player
  attr_reader :name
  attr_accessor :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def cards_joined
    @cards.join(', ')
  end

end
