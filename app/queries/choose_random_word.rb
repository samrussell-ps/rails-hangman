class ChooseRandomWord
  def next_word
    #TODO push to database
    # - scope on Word?
    # order words in db
    Word.all.sample
  end
end
