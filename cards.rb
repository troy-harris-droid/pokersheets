class Cards
  attr_accessor :deck

  def initialize
    @suite = %w[clubs diamonds hearts spades].freeze
    @card = %w[ace king queen jack 10 9 8 7 6 5 4 3 2].freeze
    @deck = []
  end

  def call
    create_deck
    shuffle
  end

  private

  def create_deck
    @suite.each do |s|
      @card.each do |c|
        @deck <<  "#{c.capitalize} of #{s.capitalize}"
      end
    end
  end

  def shuffle
    @deck.shuffle!
  end

end
