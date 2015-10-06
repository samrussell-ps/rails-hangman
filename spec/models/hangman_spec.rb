require 'rails_helper'

RSpec.describe Hangman, type: :model do
  let(:letters_to_guess) { [] }
  let(:word_to_be_guessed) { 'TELEPHONE' }
  let(:guesses_to_win) { [ 'T', 'E', 'L', 'P', 'H', 'O', 'N' ] }
  let(:guesses_to_lose) { [ 'Z', 'X', 'C', 'V', 'B', 'A', 'S', 'D', 'F' ] }
  let(:initial_lives) { 9 }
  let(:hangman) { Hangman.create!(word: word_to_be_guessed) }

  describe '#word_progress' do
    subject(:word_progress) { hangman.word_progress }

    it 'is all nil at the start' do
      expect(word_progress).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    end

    it 'uncovers "E" when we guess "E"' do
      hangman.guesses.create!(letter: 'E')
      expect(word_progress).to eq([nil, 'E', nil, 'E', nil, nil, nil, nil, 'E'])
    end

    it 'stays the same when we guess "A"' do
      hangman.guesses.create!(letter: 'A')
      hangman.reload
      expect(word_progress).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    end

    it 'uncovers "L" and "N" when we guess them' do
      hangman.guesses.create!(letter: 'L')
      hangman.guesses.create!(letter: 'N')
      hangman.reload
      expect(word_progress).to eq([nil, nil, 'L', nil, nil, nil, nil, 'N', nil])
    end
  end
end
