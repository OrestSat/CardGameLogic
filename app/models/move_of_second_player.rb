require "game_state"

class MoveOfSecondPlayer < GameState

	def initialize _game
		super _game
	end
	def get_card_from_player _card, _table, _player
		if @game.attacker == _player.id

			@game.set_game_state(MoveOfFirstPlayer.new @game)
			@game.take_card_from_player _card, _table

			@attacker = @defender
			@defender = _player.id
		else
			_player.add_card _card
		end
	end
end