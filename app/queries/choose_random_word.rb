require 'singleton'

class ChooseRandomWord
  #TODO remove this
  WORD_SOURCE_URI = 'http://www-01.sil.org/linguistics/wordlists/english/wordlist/wordsEn.txt'

  #TODO remove Singleton
  include Singleton

  def next_word
    Word.all.sample.word
  end
end
