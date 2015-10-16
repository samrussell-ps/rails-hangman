class GuessIsValid
  def initialize(guess)
    @guess = guess
  end

  def call
    guess_exists? && guess_is_a_single_uppercase_alpha_character?
  end

  private

  def guess_exists?
    @guess.present?
  end

  def guess_is_a_single_uppercase_alpha_character?
    @guess.match(/\A[A-Z]\Z/).present?
  end
end
