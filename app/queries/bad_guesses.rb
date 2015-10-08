class BadGuesses
  def initialize(game)
    @game = game
  end

  def call
    # horrible, but Enumerable.count was breaking :/
    @game.guesses.map{ |guess| guess unless @game.word.include?(guess.letter) }.compact.size
  end
end
