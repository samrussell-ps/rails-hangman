require 'net/http'
require 'singleton'

class ChooseRandomWord
  WORD_SOURCE_URI = 'http://www-01.sil.org/linguistics/wordlists/english/wordlist/wordsEn.txt'

  include Singleton

  def next_word
    words.sample
  end

  private

  def words
    @words ||= load_words
  end

  def load_words
    uri = URI.parse(WORD_SOURCE_URI)
    response = Net::HTTP.get_response(uri)
    words = response.body.split("\r\n")
  end
end
