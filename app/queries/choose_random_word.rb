class ChooseRandomWord
  def next_word
    #TODO push to database
    # - scope on Word?
    # order words in db
    #TODO do postgres locally
    Word.all.sample.word
  end
end
