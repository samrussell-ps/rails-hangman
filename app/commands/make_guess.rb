class MakeGuess
  include Shout

  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    if can_we_guess_this?
      create_guess

      publish!(:guess_created)
    else
      publish!(:guess_not_created, reasons_why_we_cant_guess_this)
    end
  end

  private

  def letter_to_guess
    @letter_in_uppercase ||= @letter.to_s.upcase
  end

  def can_we_guess_this?
    reasons_why_we_cant_guess_this.empty?
  end

  def reasons_why_we_cant_guess_this
    @reasons_why_we_cant_guess_this ||= why_cant_we_guess_this
  end

  def why_cant_we_guess_this
    @reasons_why_we_cant_guess_this = []

    @reasons_why_we_cant_guess_this << :game_over if game_over?
    @reasons_why_we_cant_guess_this << :letter_has_been_guessed if have_we_guessed_this?
    @reasons_why_we_cant_guess_this << :guess_is_invalid unless is_guess_valid?

    @reasons_why_we_cant_guess_this
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
