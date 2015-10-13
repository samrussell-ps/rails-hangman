require 'net/http'
require 'singleton'

class ChooseRandomWord
  WORD_SOURCE_URI = 'http://www-01.sil.org/linguistics/wordlists/english/wordlist/wordsEn.txt'

  include Singleton

  def next_word
    Word.all.sample.word
  end
end
