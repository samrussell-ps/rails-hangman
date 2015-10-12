class BadGuesses
  def initialize(game)
    @game = game
  end

  def call
    # TODO: rewrite
    # horrible, but Enumerable.count was breaking :/
    @game.guesses.map{ |guess| guess.letter unless @game.word.include?(guess.letter) }.compact
  end
end
