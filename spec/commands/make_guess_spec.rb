require 'rails_helper'

RSpec.describe MakeGuess do
  let(:letter) { nil }
  let(:game) { Game.create!(word: 'WORD') }
  let(:make_guess) { MakeGuess.new(game, letter) }
  let(:guesses_to_win) { [ 'W', 'O', 'R', 'D' ] }
  let(:guesses_to_lose) { [ 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'A', 'S' ] }
  subject { make_guess.call }

  context 'with nil letter' do
    let(:letter) { nil }
    subject { Proc.new { make_guess.call } }

    it { is_expected.to raise_error ActiveRecord::RecordInvalid }
  end

  context 'with an uppercase letter' do
    let(:letter) { 'A' }

    it { is_expected.to be_a_kind_of(Guess) }
  end

  context 'with a lowercase letter' do
    let(:letter) { 'a' }

    it { is_expected.to be_a_kind_of(Guess) }
  end

  context 'with multiple characters' do
    let(:letter) { 'abc' }

    subject { Proc.new { make_guess.call } }

    it { is_expected.to raise_error ActiveRecord::RecordInvalid }
  end

  context 'with a number' do
    let(:letter) { '2' }

    subject { Proc.new { make_guess.call } }

    it { is_expected.to raise_error ActiveRecord::RecordInvalid }
  end

  context 'with a symbol' do
    let(:letter) { '%' }

    subject { Proc.new { make_guess.call } }

    it { is_expected.to raise_error ActiveRecord::RecordInvalid }
  end

  context 'when the game is won' do
    let(:letter) { 'A' }

    before do
      guesses_to_win.each { |letter| game.guesses.create!(letter: letter) }
    end

    # TODO: use shout here
    it { is_expected.to be false }
  end

  context 'when the game is lost' do
    let(:letter) { 'A' }

    before do
      guesses_to_lose.each { |letter| game.guesses.create!(letter: letter) }
    end

    # TODO: use shout here
    it { is_expected.to be false }
  end
  
  context 'when the letter has already been guessed' do
    let(:letter) { 'A' }

    before do
      ['A'].each { |letter| game.guesses.create!(letter: letter) }
    end

    # TODO: use shout here
    it { is_expected.to be false }
  end
end
