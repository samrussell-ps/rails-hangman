# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#TODO: refactor
# wordlist obtained from http://www-01.sil.org/linguistics/wordlists/english/wordlist/wordsEn.txt
wordlist_path = File.join(Rails.root, 'db', 'resources', 'wordlist.txt')
wordlist = File.read(wordlist_path)
words = wordlist.split("\r\n")

ActiveRecord::Base.transaction do
  #TODO MAGIC NUMBERS ARE BAD
  words.shuffle.first(8000).each do |word|
    safe_word = word.gsub(/[^a-zA-Z]/, '')
    Word.connection.execute "INSERT INTO words (word, created_at, updated_at) values ('#{safe_word}', '#{DateTime.now()}', '#{DateTime.now()}')"
    #TODO: noSQL
    #new_records = [
    #  {:column => 'value', :column2 => 'value'}, 
    #  {:column => 'value', :column2 => 'value'}
    #]
    #
    #MyModel.create(new_records)
  end
end


