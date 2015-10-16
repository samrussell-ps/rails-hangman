require 'rails_helper'

RSpec.describe MakeGuess do
  let(:guess) { '' }
  let(:game) { Game.create!(word: 'WORD') }
  let(:game_id) { game.id }
  let(:make_guess) { MakeGuess.new(game_id, guess) }
  let(:true_service) { Proc.new { true } }
  let(:false_service) { Proc.new { false } }
  subject(:call) { make_guess.call }

  context 'with valid data and state' do
    let(:fake_guess) { instance_double(Guess) }

    it 'shout :guess_created with a new guess' do
      allow(Game).to receive(:find_by).and_return(game)
      allow(GuessIsValid).to receive(:new).and_return(true_service)
      allow(GameComplete).to receive(:new).and_return(false_service)
      allow(LetterHasBeenGuessed).to receive(:new).and_return(false_service)

      expect(Guess).to receive(:create!).with(hash_including(game: game, letter: anything)).and_return(fake_guess)
      expect(make_guess).to receive(:publish!).with(:guess_created)

      make_guess.call
    end
  end

  context 'with a non_existent game' do
    it 'shouts :game_does_not_exist' do
      allow(Game).to receive(:find_by).and_return(nil)
      allow(GuessIsValid).to receive(:new).and_return(false_service)
      allow(GameComplete).to receive(:new).and_return(false_service)
      allow(LetterHasBeenGuessed).to receive(:new).and_return(false_service)

      expect(make_guess).to receive(:publish!).with(:game_does_not_exist)

      make_guess.call
    end
  end

  context 'with an invalid guess' do
    it 'shouts :guess_is_invalid' do
      allow(Game).to receive(:find_by).and_return(instance_double(Game))
      allow(GuessIsValid).to receive(:new).and_return(false_service)
      allow(GameComplete).to receive(:new).and_return(false_service)
      allow(LetterHasBeenGuessed).to receive(:new).and_return(false_service)

      expect(make_guess).to receive(:publish!).with(:guess_is_invalid)

      make_guess.call
    end
  end

  context 'when the game is complete' do
    it 'shouts :game_complete' do
      allow(Game).to receive(:find_by).and_return(instance_double(Game))
      allow(GuessIsValid).to receive(:new).and_return(true_service)
      allow(GameComplete).to receive(:new).and_return(true_service)
      allow(LetterHasBeenGuessed).to receive(:new).and_return(false_service)

      expect(make_guess).to receive(:publish!).with(:game_complete)

      make_guess.call
    end
  end
  
  context 'when the letter has already been guessed' do
    it 'shouts :letter_has_been_guessed' do
      allow(Game).to receive(:find_by).and_return(instance_double(Game))
      allow(GuessIsValid).to receive(:new).and_return(true_service)
      allow(GameComplete).to receive(:new).and_return(false_service)
      allow(LetterHasBeenGuessed).to receive(:new).and_return(true_service)

      expect(make_guess).to receive(:publish!).with(:letter_has_been_guessed)

      make_guess.call
    end
  end
end
