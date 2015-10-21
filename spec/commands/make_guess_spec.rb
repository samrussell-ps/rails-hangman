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
    context 'with letter A, no letters guessed' do
      let(:letter_to_guess) { 'A' }

      it 'calls publish! with :guess_created' do
        expect(make_guess).to receive(:publish!).with(:guess_created)

        make_guess.call
      end

      it 'creates a new guess' do
        allow(make_guess).to receive(:publish!).with(:guess_created)

        expect { make_guess.call }.to change { game.guesses.size }.by(1)
      end
    end

    context 'with letter a' do
      let(:letter_to_guess) { 'a' }

      it 'calls publish! with :guess_created' do
        expect(make_guess).to receive(:publish!).with(:guess_created)

        make_guess.call
      end

      it 'creates a new guess' do
        allow(make_guess).to receive(:publish!).with(:guess_created)

        expect { make_guess.call }.to change { game.guesses.size }.by(1)
      end
    end

    context 'with letter A, game over (won)' do
      let(:letter_to_guess) { 'A' }

      before do
        guesses_to_win.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it 'calls publish! with :guess_not_created. [:game_over]' do
        expect(make_guess).to receive(:publish!).with(:guess_not_created, array_including(:game_over))

        make_guess.call
      end

      it 'does not create a new guess' do
        allow(make_guess).to receive(:publish!).with(:guess_not_created, anything)

        expect { make_guess.call }.to_not change { game.guesses.size }
      end
    end

    context 'with letter A, game over (lost)' do
      let(:letter_to_guess) { 'A' }

      before do
        guesses_to_lose.each do |letter|
          game.guesses.create(letter: letter)
        end
      end

      it 'calls publish! with :guess_not_created. [:game_over]' do
        expect(make_guess).to receive(:publish!).with(:guess_not_created, array_including(:game_over))

        make_guess.call
      end

      it 'does not create a new guess' do
        allow(make_guess).to receive(:publish!).with(:guess_not_created, anything)

        expect { make_guess.call }.to_not change { game.guesses.size }
      end
    end

    context 'with letter A, letter has been guessed' do
      let(:previous_guess) { 'A' }
      let(:letter_to_guess) { 'A' }

      before do
        game.guesses.create(letter: previous_guess)
      end

      it 'calls publish! with :guess_not_created. [:letter_has_been_guessed]' do
        expect(make_guess).to receive(:publish!).with(:guess_not_created, array_including(:letter_has_been_guessed))

        make_guess.call
      end

      it 'does not create a new guess' do
        allow(make_guess).to receive(:publish!).with(:guess_not_created, anything)

        expect { make_guess.call }.to_not change { game.guesses.size }
      end
    end

    context 'with letter %' do
      let(:letter_to_guess) { '%' }

      it 'calls publish! with :guess_not_created. [:guess_is_invalid]' do
        expect(make_guess).to receive(:publish!).with(:guess_not_created, array_including(:guess_is_invalid))

        make_guess.call
      end

      it 'does not create a new guess' do
        allow(make_guess).to receive(:publish!).with(:guess_not_created, anything)

        expect { make_guess.call }.to_not change { game.guesses.size }
      end
    end

    context 'with letter 2' do
      let(:letter_to_guess) { '2' }

      it 'calls publish! with :guess_not_created. [:guess_is_invalid]' do
        expect(make_guess).to receive(:publish!).with(:guess_not_created, array_including(:guess_is_invalid))

        make_guess.call
      end

      it 'does not create a new guess' do
        allow(make_guess).to receive(:publish!).with(:guess_not_created, anything)

        expect { make_guess.call }.to_not change { game.guesses.size }
      end
    end
  end
end
