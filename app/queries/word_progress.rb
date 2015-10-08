class WordProgress
  def initialize(game)
    @game = game
  end

  def call
    @game.word.chars.map do |letter|
      letter if @game.guesses.any? do |guess|
        guess.letter == letter
      end
    end
  end
end
