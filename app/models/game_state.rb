class GameState
	def initialize _game
		@game = _game
	end

	def init_player _player
		operation_is_not_allowed "init_player"
	end

	def prepare_game_to_start _deck
		operation_is_not_allowed "prepare_game_to_start"
	end

	def get_card_from_player _card, _player
		operation_is_not_allowed "get_card_from_player"
	end

	def operation_is_not_allowed operation_name
		puts "Oparation #{operation_name} is not allowed for Order's state #{@game.state.class.nameSS}" 
	end
end