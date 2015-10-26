class GuessController < ApplicationController
  # how do we pass something other than string through flash[]?
  # TODO mock service, inject "test error string", assert string ends up in flash
  ERROR_MESSAGES = {
    letter_has_been_guessed: "That letter has already been guessed",
    game_does_not_exist: "That game does not exist",
    game_over: "The game is over!",
    guess_is_invalid: "Whoops, that guess was invalid"
  }

  def create
    if game_exists?
      make_guess
    else
      route_to_game_index
    end
  end

  private

  def make_guess
    guess_maker = MakeGuess.new(game, letter_to_guess)

    guess_maker.on(:guess_created) { route_to_game }
    guess_maker.on(:guess_not_created) { |errors| route_to_game(errors) }
    
    guess_maker.call
  end

  def letter_to_guess
    params[:letter]
  end

  def game_exists?
    game.present?
  end

  def game
    # TODO this should be allowed to blow up, shouldn't handle quietly
    @game ||= Game.find_by(id: params[:game_id])
  end

  def route_to_game(errors = [])
    # just use the first alert
    set_alert_message(errors.first) unless errors.empty?

    redirect_to controller: 'game', action: 'show', id: params[:game_id]
  end

  def route_to_game_index
    set_alert_message(:game_does_not_exist)

    redirect_to controller: 'game', action: 'index'
  end

  def set_alert_message(alert)
    flash[:alert] = ERROR_MESSAGES[alert]
  end
end
