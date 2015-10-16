class MakeGuess
  include Shout

  def initialize(game_id, letter)
    @game_id = game_id
    #TODO: test fail on not-string
    @uppercase_letter = letter.to_s.upcase
  end

  def call
    if game_does_not_exist?
      publish!(:game_does_not_exist)
    # TODO: refactor these into private methods
    elsif guess_is_invalid?
      publish!(:invalid_guess)
    elsif GameComplete.new(game).call
      publish!(:game_complete)
    elsif LetterHasBeenGuessed.new(game, @uppercase_letter).call
      publish!(:letter_has_been_guessed)
    else
      guess = Guess.create!(game: game, letter: @uppercase_letter)
      #TODO don't pass guess
      publish!(:guess_created, guess)
    end
  end

  private

  def game
    Game.find_by(id: @game_id)
  end

  def game_does_not_exist?
    game.nil?
  end

  def guess_is_invalid?
    !GuessIsValid.new(@uppercase_letter).call
  end
end
