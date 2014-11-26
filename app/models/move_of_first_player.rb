require "move_of_second_player"
require "game_state"

class MoveOfFirstPlayer < GameState

	def initialize _game
		super _game
	end
	def get_card_from_player _card, _player_id
		if @game.attacker == _player_id

			@game.set_game_state(MoveOfSecondPlayer.new @game)
			@game.do_get_card_from_player _card

			@game.attacker = @game.defender
			@game.defender = _player_id
		else
			@game.players[1].add_card _card
		end
	end

	# def put_card_on_table(_card )
	# 	if @game.attacker == self.players[0].id
	# 		@game.push_card( _card )
	# 		@game.set_game_state(MoveOfSecondPlayer.new @game)

	# 		@game.attacker = @game.defender
	# 		@game.defender = self.players[0].id
	# 	end
	# end
end
