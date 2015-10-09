class MakeGame
  def initialize
  end

  def call
    word = ChooseRandomWord.instance.next_word
    Game.create!(word: word.upcase)
  end
end
