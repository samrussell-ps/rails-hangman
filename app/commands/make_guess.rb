class MakeGuess #TODO submit vs make
  ERROR_MESSAGES = {
    letter_has_been_guessed: "That letter has already been guessed",
    game_over: "The game is over!",
    guess_is_invalid: "Whoops, that guess was invalid"
  }

  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    # TODO ? method shouldn't change state, only inspecting
    # check_if_guess_can_be_made
    create_guess if can_we_guess_this?

    errors.empty?
  end

  def errors
    @errors ||= why_cant_we_guess_this
  end

  private

  def letter_to_guess
    @letter_in_uppercase ||= @letter.to_s.upcase
  end

  # TODO "we" and "this" are bad, reword
  def can_we_guess_this?
    errors.empty?
  end

  def why_cant_we_guess_this
    reasons_why_we_cant_guess_this = []

    reasons_why_we_cant_guess_this << ERROR_MESSAGES[:game_over] if game.over?
    reasons_why_we_cant_guess_this << ERROR_MESSAGES[:letter_has_been_guessed] if have_we_guessed_this?
    reasons_why_we_cant_guess_this << ERROR_MESSAGES[:guess_is_invalid] unless is_guess_valid?

    reasons_why_we_cant_guess_this
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
