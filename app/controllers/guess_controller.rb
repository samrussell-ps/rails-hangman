class GuessController < ApplicationController
  def create
    Guess.new(params.permit(:game_id, :letter)).save
    redirect_to controller: 'game', action: 'show', id: params[:game_id]
  end
end
