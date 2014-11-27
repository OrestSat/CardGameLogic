class GameController < ApplicationController

  # GET /games/1
  # GET /games/1.json
  def show
    
  end

	# GET /game/new
	def new
     @game = Game.new
  end

  # POST /game
  # POST /game.json
  def create
  	@game = Game.new(game_params)
    @game.init
    @game.init_state
    @game.init_player self.current_user
    @game.players[0].save

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Card game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @game }
      else
        format.html { render action: 'new' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

      def game_params
      params.require(:game).permit(:name, :description)
    end
end
