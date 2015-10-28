class CreateGame
  def call
    word = ChooseRandomWord.new.next_word
    Game.create!(words: [word])
  end
end
