class GuessController < ApplicationController
  def create
    #Guess.new(params.permit(:game_id, :letter)).save
    # TODO: handle when guess wasn't created
    MakeGuess.new(Game.find(params[:game_id]), params[:letter]).call
    redirect_to controller: 'game', action: 'show', id: params[:game_id]
  end
end
