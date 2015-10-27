require 'rails_helper'

RSpec.describe GamePresenter do
  let(:params) { {} }
  let(:game) { Game.create(params) }
  subject(:game_presenter) { GamePresenter.new(game) }

  context 'with word BUCKET' do
    let(:word_to_guess) { Word.create!(word: 'BUCKET') }
    let(:params) { { word: word_to_guess } }

    describe '#word_progress' do
      subject(:word_progress) { game_presenter.word_progress }

      context 'with no guesses' do
        it { is_expected.to eq('_ _ _ _ _ _') }
      end

      context 'with U and C guessed' do
        let(:two_correct_letters) { [ 'U', 'C' ] }

        before do
          two_correct_letters.each do |letter|
            game.guesses.create(letter: letter)
          end
        end

        it { is_expected.to eq('_ U C _ _ _') }
      end

      context 'with A and Z guessed' do
        let(:two_incorrect_letters) { [ 'A', 'Z' ] }

        before do
          two_incorrect_letters.each do |letter|
            game.guesses.create(letter: letter)
          end
        end

        it { is_expected.to eq('_ _ _ _ _ _') }
      end
    end

    describe '#incorrect_guesses' do
      subject(:incorrect_guesses) { game_presenter.incorrect_guesses }

      context 'with no guesses' do
        it { is_expected.to eq('') }
      end

      context 'with U and C guessed' do
        let(:two_correct_letters) { [ 'U', 'C' ] }

        before do
          two_correct_letters.each do |letter|
            game.guesses.create(letter: letter)
          end
        end

        it { is_expected.to eq('') }
      end

      context 'with A and Z guessed' do
        let(:two_incorrect_letters) { [ 'A', 'Z' ] }

        before do
          two_incorrect_letters.each do |letter|
            game.guesses.create(letter: letter)
          end
        end

        it { is_expected.to eq('A Z') }
      end
    end

    describe '#lives_left' do
      let(:initial_lives) { 9 }
      subject(:lives_left) { game_presenter.lives_left }

      context 'with no guesses' do
        it { is_expected.to eq(9) }
      end

      context 'with U and C guessed' do
        let(:two_correct_letters) { [ 'U', 'C' ] }

        before do
          two_correct_letters.each do |letter|
            game.guesses.create(letter: letter)
          end
        end

        it { is_expected.to eq(9) }
      end

      context 'with A and Z guessed' do
        let(:two_incorrect_letters) { [ 'A', 'Z' ] }

        before do
          two_incorrect_letters.each do |letter|
            game.guesses.create(letter: letter)
          end
        end

        it { is_expected.to eq(7) }
      end
    end

    describe '#game_over?' do
      let(:guesses_to_win) { %w[B U C K E T] }
      let(:guesses_to_lose) { %w[Z X V W N M L J H] }

      subject(:game_over?) { game_presenter.game_over? }

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

    describe '#game_won?' do
      let(:guesses_to_win) { %w[B U C K E T] }
      let(:guesses_to_lose) { %w[Z X V W N M L J H] }

      subject(:game_won?) { game_presenter.game_won? }

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

    describe '#game_lost?' do
      let(:guesses_to_win) { %w[B U C K E T] }
      let(:guesses_to_lose) { %w[Z X V W N M L J H] }

      subject(:game_lost?) { game_presenter.game_lost? }

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

    describe '#word' do
      subject(:word) { game_presenter.word }

      it { is_expected.to eq word_to_guess }
    end
  end
end
