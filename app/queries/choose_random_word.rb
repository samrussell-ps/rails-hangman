class ChooseRandomWord
  def next_word
    # TODO should be under Word, SQL stuff lives in model
    Word.order("RANDOM()").first
  end
end
