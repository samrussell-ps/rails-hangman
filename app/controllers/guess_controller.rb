class GuessController < ApplicationController
  def create
    make_guess
  end

  private

  def make_guess
    guess_maker = MakeGuess.new(game, letter_to_guess)

    guess_maker.call

    flash[:alert] = guess_maker.errors.first unless guess_maker.errors.empty?

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

  def route_to_game(errors = [])
    # just use the first alert
    #set_alert_message(errors.first) unless errors.empty?

    redirect_to controller: 'game', action: 'show', id: params[:game_id]
  end

  def route_to_game_index
    set_alert_message(:game_does_not_exist)

    redirect_to controller: 'game', action: 'index'
  end

  def set_alert_message(alert)
    flash[:alert] = MakeGuess::ERROR_MESSAGES[alert]
  end
end
