require "new_game"
require "deck"
require "card"

class Game < ActiveRecord::Base

	has_many :players
	has_one :deck
	has_one :table

	def init_state
    case self.state_name
    when 'NewGame'
    	@state = NewGame.new self
    when 'ExpectationOfSecondPlayer'
    	@state = ExpectationOfSecondPlayer.new self
    when 'GamePrepare'
    	@state = GamePrepare.new self
    when 'MoveOfFirstPlayer'
    	@state = MoveOfFirstPlayer.new self
    when 'MoveOfSecondPlayer'
    	@state = MoveOfSecondPlayer.new self
    end
    @state
	end

	def set_game_state _state
		@state = _state
		self.state_name = _state.class.name
	end
	# def get_game_state
	# 	self.state
	# end
	def init
		@state = NewGame.new(self)
		# Deck.create({:game => self})
	end

	# def create_deck
	#   Deck.create({:game => self}).init_cards
	# end

	def init_player _user
		@state.init_player _user
	end

	def prepare_game_to_start
		@state.prepare_game_to_start
	end

	def get_card_from_player _card, _player_id
		@state.get_card_from_player _card, _player_id
	end

	def do_init_first_player _user
		puts "Doing init first player..."
		player = Player.create({:game => self, :user => _user})
		self.attacker = player.id
	end

	def do_init_second_player _user
		puts "Doing init second player..."
		player = Player.create({:game => self, :user => _user})
		self.defender = player.id
	end

	def do_preparation_for_game
		puts "Doing preparation for game..."
		table = Table.create({:game => self, :cards_count => 0})
		deck = Deck.create({:game => self})
		deck.init_cards
		6.times do
			self.players[0].add_card (deck.get_one)
			self.players[1].add_card (deck.get_one)
		end
	end

	def do_get_card_from_player _card
		self.table.add_card(_card)
	end

	# def push_card(_card)
	# 	self.table.add_card _card
	# end


	def self.search(search)
		if search
			find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
		else
			find(:all)
		end
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

# crd = game.player2.put_card 0/
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
