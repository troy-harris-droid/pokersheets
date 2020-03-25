require_relative 'Googlesheets'
require_relative 'Cards'
require_relative 'Player'

class Run

  def initialize
    @gsheet = Googlesheets.new
    @shuffled_deck = Cards.new.call
    @burnt_cards = []
    @players = []
    @community_cards = []
    @game = Time.now
    @round = 1
  end

  def call(player_names)
    @gsheet.call
    load_players(player_names)
    deal # 1
    upload_round
    increment_round
    deal # 2
    upload_round
    increment_round
    deal # 3
    upload_round
    increment_round
    puts "Game complete!"
  end

  private

  def deal
    case @round
    when 1
      burn_card
      puts "*" * 20
      puts "Dealing Round 1"
      puts "*" * 20
      deal_players
      deal_community
    when 2
      burn_card
      puts "*" * 20
      puts "Dealing Round 2"
      puts "*" * 20
      deal_community
    when 3
      burn_card
      puts "*" * 20
      puts "Dealing Round 3"
      puts "*" * 20
      deal_community
    end

  end

  def burn_card
    @burnt_cards << @shuffled_deck.pop(1)
  end

  def load_players(player_names)
    player_names.each do |player|
      @players << Player.new(player)
      puts "Created Player: #{player}"
    end
  end

  def upload_round
    @gsheet.write(build_upload_row)
  end

  def increment_round
    @round += 1
  end

  def build_upload_row
    row = [@game, @round, @community_cards.join(', ')]
    @players.each do |p|
      row << p.cards_joined
    end
    row.flatten
  end

  def deal_players
    puts "No players found" if @players.empty?
    @players.each do |player|
      player.cards = @shuffled_deck.pop(2)
      puts "Dealt #{player.name}: cards: #{player.cards}"
    end
  end

  def deal_community
    if @round == 1
      @community_cards = @shuffled_deck.pop(3)
    else
      @community_cards << @shuffled_deck.pop(1)
    end
    puts "Dealt Community: cards: #{@community_cards}"
  end

end

Run.new.call(['Troy', 'Koksey'])