class CreateGame
  def call
    word = ChooseRandomWord.new.next_word
    Game.create!(word: word)
  end
end
