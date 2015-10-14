# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#TODO: refactor
require 'net/http'
WORD_SOURCE_URI = 'http://www-01.sil.org/linguistics/wordlists/english/wordlist/wordsEn.txt'

uri = URI.parse(WORD_SOURCE_URI)
response = Net::HTTP.get_response(uri)
words = response.body.split("\r\n")

ActiveRecord::Base.transaction do
  #words.each { |word| Word.find_or_create_by(word: word) }
  #words.each { |word| Word.create!(word: word) }
  words.shuffle[0...8000].each do |word|
    safe_word = word.gsub(/[^a-zA-Z]/, '')
    Word.connection.execute "INSERT INTO words (word, created_at, updated_at) values ('#{safe_word}', '#{DateTime.now()}', '#{DateTime.now()}')"
  end
end


