require 'rails_helper'

RSpec.describe MakeGuess do
  let(:word_to_guess) { 'BUCKET' }
  let(:params) { { word: word_to_guess } }
  let(:game) { Game.create!(params) }
  let(:letter_to_guess) { nil }
  let(:make_guess) { MakeGuess.new(game, letter_to_guess) }
  let(:guesses_to_win) { %w[B U C K E T] }
  let(:guesses_to_lose) { %w[Z X V W N M L J H] }

  describe '#call' do
    subject(:call) { make_guess.call }

    context 'with letter A, no letters guessed' do
      let(:letter_to_guess) { 'A' }

      it { is_expected.to be true }

      it 'creates a new guess' do
        expect { make_guess.call }.to change { game.guesses.size }.by(1)
      end

      it 'does not set error' do
        expect(make_guess.errors).to eq([])
      end
    end

    context 'with letter a' do
      let(:letter_to_guess) { 'a' }

      it { is_expected.to be true }

      it 'creates a new guess' do
        expect { make_guess.call }.to change { game.guesses.size }.by(1)
      end

      it 'does not set error' do
        expect(make_guess.errors).to eq([])
      end
    end

    context 'with letter A, game over (won)' do
      let(:letter_to_guess) { 'A' }

      before do
        guesses_to_win.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be false }

      it 'does not create a new guess' do
        expect { make_guess.call }.to_not change { game.guesses.size }
      end

      it 'sets "game over" error' do
        expect(make_guess.errors).to contain_exactly(MakeGuess::ERROR_MESSAGES[:game_over])
      end
    end

    context 'with letter A, game over (lost)' do
      let(:letter_to_guess) { 'A' }

      before do
        guesses_to_lose.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it { is_expected.to be false }

      it 'does not create a new guess' do
        expect { make_guess.call }.to_not change { game.guesses.size }
      end

      it 'sets "game over" error' do
        expect(make_guess.errors).to contain_exactly(MakeGuess::ERROR_MESSAGES[:game_over])
      end
    end

    context 'with letter A, letter has been guessed' do
      let(:previous_guess) { 'A' }
      let(:letter_to_guess) { 'A' }

      before do
        game.guesses.create(letter: previous_guess)
      end

      it { is_expected.to be false }

      it 'does not create a new guess' do
        expect { make_guess.call }.to_not change { game.guesses.size }
      end

      it 'sets "letter has been guessed" error' do
        expect(make_guess.errors).to contain_exactly(MakeGuess::ERROR_MESSAGES[:letter_has_been_guessed])
      end
    end

    context 'with letter %' do
      let(:letter_to_guess) { '%' }

      it { is_expected.to be false }

      it 'does not create a new guess' do
        expect { make_guess.call }.to_not change { game.guesses.size }
      end

      it 'sets "guess is invalid" error' do
        expect(make_guess.errors).to contain_exactly(MakeGuess::ERROR_MESSAGES[:guess_is_invalid])
      end
    end

    context 'with letter 2' do
      let(:letter_to_guess) { '2' }

      it { is_expected.to be false }

      it 'does not create a new guess' do
        expect { make_guess.call }.to_not change { game.guesses.size }
      end

      it 'sets "guess is invalid" error' do
        expect(make_guess.errors).to contain_exactly(MakeGuess::ERROR_MESSAGES[:guess_is_invalid])
      end
    end
  end
end
