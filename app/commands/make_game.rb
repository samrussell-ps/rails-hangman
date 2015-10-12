class MakeGame
  def call
    word = ChooseRandomWord.instance.next_word
    Game.create!(word: word.upcase)
  end
end
