class MakeGame
  def call
    word = ChooseRandomWord.new.next_word
    Game.create!(word: word.upcase)
  end
end
