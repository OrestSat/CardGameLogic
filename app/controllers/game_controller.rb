class GameController < ApplicationController
  def show
  end
  
  def card_game_params
  	params.require(:card_game).permit(:title, :notes)
  end
end
