class MakeGuess
  include Shout

  def initialize(game_id, letter)
    @game_id = game_id
    @uppercase_letter = letter.to_s.upcase
  end

  def call
    #TODO ask Policy object whether we can make the guess
    #authentication etc
    if game_does_not_exist?
      publish!(:game_does_not_exist)
    elsif guess_is_invalid?
      publish!(:guess_is_invalid)
    elsif game_is_complete?
      publish!(:game_complete)
    elsif letter_has_been_guessed?
      publish!(:letter_has_been_guessed)
    else
      create_guess

      publish!(:guess_created)
    end
  end

  private

  def game
    #TODO memoize @game ||=
    Game.find_by(id: @game_id)
  end

  def game_does_not_exist?
    game.nil?
  end

  def guess_is_invalid?
    #TODO make GuessIsInvalid as query
    !GuessIsValid.new(@uppercase_letter).call
  end

  def game_is_complete?
    # policy
    GameComplete.new(game).call
  end

  def letter_has_been_guessed?
    # policy
    LetterHasBeenGuessed.new(game, @uppercase_letter).call
  end

  def create_guess
    #TODO game.guesses.create
    Guess.create!(game: game, letter: @uppercase_letter)
  end
end
