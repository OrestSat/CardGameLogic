require "new_game"

class Game < ActiveRecord::Base
	serialize :state, Array

has_many :players
has_one :deck
has_one :table

	# def set_game_state _state
	# 	self.state = _state
	# end
	# def get_game_state
	# 	self.state
	# end
  def initialize
    super
    create_deck
    self.state = NewGame.new(self)
    # Deck.create({:game => self})
  end

  def create_deck
    Deck.create({:game => self}, :without_protection => true).init_cards
  end

	def init_player _player
		self.state.init_player _player
	end

	def prepare_game_to_start _deck
		self.state.prepare_game_to_start
	end

	def get_card_from_player _card, _player
		self.state.get_card_from_player _card, _player
	end

	def do_init_firs_player _user
		puts "Doing init first player..."
		player = Player.create({:game => self, :user => _user}, :without_protection => true)
		self.attacker = player.id
	end

	def do_init_second_player _user
		puts "Doing init second player..."
		player Player.create({:game => self, :user => _user}, :without_protection => true)
		self.defender = player.id
	end

	def do_preparation_for_game _deck
		puts "Doing preparation for game..."
		_deck.init_cards
		# 6.times do
		# 	player1.add_card (self.deck.get_card)
		# 	player2.add_card (self.deck.get_card)
		# end
		# self.attacker = player1
	end

	def take_card_from_player _card, _table
		_table.add_card(_card)
	end
end


# #створюємо користувача
# pl1 = Player.new
# pl2 = Player.new

# #створюємо гру
# game = Game.new

# game.prepare_game_to_start
# game.init_player pl1
# game.prepare_game_to_start

# puts game.player1.cards

# crd = Card.new "a", 1
# game.get_card_from_player crd, pl1

# game.prepare_game_to_start

# game.init_player pl2
# game.prepare_game_to_start
# puts "////////"
# game.player2.cards.each do |card|
# 	puts card.rang
# end
# puts "///////"
# game.player1.cards.each do |card|
# 	puts card.rang
# end
# puts "Get card from player"

# crd = game.player2.put_card 0
# game.get_card_from_player crd, pl2
# crd = game.player2.put_card 1
# game.get_card_from_player crd, pl2

# game.player2.cards.each do |card|
# 	puts card.rang
# end

# puts "///////"
# game.player1.cards.each do |card|
# 	puts card.rang
# end

# crd = game.player1.put_card 0
# game.get_card_from_player crd, pl1

# game.player1.cards.each do |card|
# 	puts card.rang
# end
