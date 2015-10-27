class MakeGuess
  ERROR_MESSAGES = {
    letter_has_been_guessed: "That letter has already been guessed",
    game_over: "The game is over!",
    guess_is_invalid: "Whoops, that guess was invalid"
  }

  attr_reader :errors

  include Shout

  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    if can_we_guess_this?
      create_guess

      true
    else
    end

    errors.empty?
  end

  def errors
    @errors||= why_cant_we_guess_this
  end

  private

  def letter_to_guess
    @letter_in_uppercase ||= @letter.to_s.upcase
  end

  def can_we_guess_this?
    errors.empty?
  end

  def why_cant_we_guess_this
    reasons_why_we_cant_guess_this = []

    reasons_why_we_cant_guess_this << ERROR_MESSAGES[:game_over] if game_over?
    reasons_why_we_cant_guess_this << ERROR_MESSAGES[:letter_has_been_guessed] if have_we_guessed_this?
    reasons_why_we_cant_guess_this << ERROR_MESSAGES[:guess_is_invalid] unless is_guess_valid?

    reasons_why_we_cant_guess_this
  end

  def game_over?
    game.over?
  end

  def have_we_guessed_this?
    game.have_we_guessed?(letter_to_guess)
  end

  def is_guess_valid?
    game.is_guess_valid?(letter_to_guess)
  end

  def game
    @game
  end

  def create_guess
    game.create_guess(letter_to_guess)
  end
end
