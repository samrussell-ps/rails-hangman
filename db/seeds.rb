# Heroku gives us 10000 free database entries
NUMBER_OF_WORDS_TO_LOAD = 8000

# wordlist obtained from http://www-01.sil.org/linguistics/wordlists/english/wordlist/wordsEn.txt
wordlist_path = File.join(Rails.root, 'db', 'resources', 'wordlist.txt')

wordlist = File.read(wordlist_path)

words = wordlist.split("\r\n")

words_to_load = words.shuffle.first(NUMBER_OF_WORDS_TO_LOAD)

valid_words_to_load = words_to_load.select { |word| word.match(/\A[A-Za-z]+\z/).present? }

word_arguments = valid_words_to_load.map { |word| { word: word.upcase } }

ActiveRecord::Base.transaction do
  Word.destroy_all

  Word.create!(word_arguments)
end


