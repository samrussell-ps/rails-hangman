class ChooseRandomWord
  def next_word
    Word.order("RANDOM()").first
  end
end
