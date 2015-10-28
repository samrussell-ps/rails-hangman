class GuessController < ApplicationController
  def create
    make_guess

    route_to_game
  end

  private

  def make_guess
    guess_maker.call

    set_errors
  end

  def guess_maker
    @guess_maker ||= MakeGuess.new(game, letter_to_guess)
  end

  def letter_to_guess
    params[:letter]
  end

  def game
    @game ||= Game.find(params[:game_id])
  end

  def set_errors
    flash[:alert] = guess_maker.errors.first unless guess_maker.errors.empty?
  end

  def route_to_game
    redirect_to controller: 'game', action: 'show', id: params[:game_id]
  end
end
