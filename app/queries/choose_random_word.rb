class ChooseRandomWord
  def next_word
    Word.all.sample.word
  end
end
