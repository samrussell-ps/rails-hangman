class GuessIsValid
  def initialize(guess)
    @guess = guess
  end

  def call
    guess_is_not_nil && guess_is_a_single_uppercase_alpha_character
  end

  private

  def guess_is_not_nil
    !@guess.nil?
  end

  def guess_is_a_single_uppercase_alpha_character
    !!(@guess.match(/\A[A-Z]\Z/))
  end
end
