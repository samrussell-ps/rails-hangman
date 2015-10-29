require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:params) { {} }
  let(:word_to_guess) { Word.create!(word: 'BUCKET') }
  subject(:game) { Game.create(params) }

  context "game with no word" do
    it { is_expected.to_not be_valid }
  end

  context "game with word in uppercase" do
    let(:params) { { word: word_to_guess } }

    it { is_expected.to be_valid }
  end

  describe '#correctly_guessed_letters' do
    let(:params) { { word: word_to_guess } }

    subject(:correctly_guessed_letters) { game.correctly_guessed_letters }

    context 'with no guesses' do
      it { is_expected.to be_empty }
    end

    context 'with 2 correct guesses' do
      let(:two_correct_letters) { [ 'U', 'C' ] }

      before do
        two_correct_letters.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to contain_exactly(*two_correct_letters) }
    end

    context 'with 2 incorrect guesses' do
      let(:two_incorrect_letters) { [ 'A', 'Z' ] }

      before do
        two_incorrect_letters.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be_empty }
    end
  end

  describe '#incorrectly_guessed_letters' do
    let(:params) { { word: word_to_guess } }

    subject(:incorrectly_guessed_letters) { game.incorrectly_guessed_letters }

    context 'with no guesses' do
      it { is_expected.to be_empty }
    end

    context 'with 2 correct guesses' do
      let(:two_correct_letters) { [ 'U', 'C' ] }

      before do
        two_correct_letters.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be_empty }
    end

    context 'with 2 incorrect guesses' do
      let(:two_incorrect_letters) { [ 'A', 'Z' ] }

      before do
        two_incorrect_letters.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to contain_exactly(*two_incorrect_letters) }
    end
  end

  describe '#have_we_guessed?' do
    let(:params) { { word: word_to_guess } }
    let(:letter_to_guess) { 'B' }

    subject(:have_we_guessed?) { game.have_we_guessed?(letter_to_guess) }

    context 'with no guesses' do
      it { is_expected.to be false }
    end

    context 'with the letter guessed' do
      before do
        game.guesses.create(letter: letter_to_guess)
      end

      it { is_expected.to be true }
    end
  end

  describe '#over?' do
    let(:params) { { word: word_to_guess } }
    let(:guesses_to_win) { %w[B U C K E T] }
    let(:guesses_to_lose) { %w[Z X V W N M L J H] }

    subject(:over?) { game.over? }

    context 'with no guesses' do
      it { is_expected.to be false }
    end

    context 'with the word guessed' do
      before do
        guesses_to_win.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be true }
    end

    context 'with all lives used up' do
      before do
        guesses_to_lose.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be true }
    end
  end

  describe '#won?' do
    let(:params) { { word: word_to_guess } }
    let(:guesses_to_win) { %w[B U C K E T] }
    let(:guesses_to_lose) { %w[Z X V W N M L J H] }

    subject(:won?) { game.won? }

    context 'with no guesses' do
      it { is_expected.to be false }
    end

    context 'with the word guessed' do
      before do
        guesses_to_win.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be true }
    end

    context 'with all lives used up' do
      before do
        guesses_to_lose.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be false }
    end
  end

  describe '#lost?' do
    let(:params) { { word: word_to_guess } }
    let(:guesses_to_win) { %w[B U C K E T] }
    let(:guesses_to_lose) { %w[Z X V W N M L J H] }

    subject(:lost?) { game.lost? }

    context 'with no guesses' do
      it { is_expected.to be false }
    end

    context 'with the word guessed' do
      before do
        guesses_to_win.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be false }
    end

    context 'with all lives used up' do
      before do
        guesses_to_lose.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be true }
    end
  end

  describe '#lives_left' do
    let(:params) { { word: word_to_guess } }
    let(:initial_number_of_lives) { 9 }
    let(:guesses_to_win) { %w[B U C K E T] }
    let(:guesses_to_lose) { %w[Z X V W N M L J H] }

    subject(:lives_left) { game.lives_left }

    context 'with no guesses' do
      it { is_expected.to be initial_number_of_lives }
    end

    context 'with the word guessed' do
      before do
        guesses_to_win.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be initial_number_of_lives }
    end

    context 'with all lives used up' do
      before do
        guesses_to_lose.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be 0 }
    end
  end

  describe '#create_guess' do
    let(:letter_to_guess) { 'B' }

    it 'creates a guess' do
      #TODO
    end
  end
end
