class WordProgress
  def initialize(game)
    @game = game
  end

  def call
    @game.word.chars.map do |letter|
      letter if letter_has_been_guessed?(letter)
    end
  end

  private

  # TODO: use LetterHasBeenGuessed
  def letter_has_been_guessed?(letter)
    @game.guesses.any? { |guess| guess.letter == letter }
  end
end
