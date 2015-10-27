class GuessController < ApplicationController
  def create
    make_guess
  end

  private

  def make_guess
    guess_maker = MakeGuess.new(game, letter_to_guess)

    guess_maker.call

    set_errors(guess_maker.errors.first) unless guess_maker.errors.empty?

    route_to_game
  end

  def letter_to_guess
    params[:letter]
  end

  def game_exists?
    game.present?
  end

  def game
    @game ||= Game.find(params[:game_id])
  end

  def set_errors(errors)
    flash[:alert] = errors
  end

  def route_to_game
    redirect_to controller: 'game', action: 'show', id: params[:game_id]
  end
end
