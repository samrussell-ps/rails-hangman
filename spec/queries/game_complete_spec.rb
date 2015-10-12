require 'rails_helper'

RSpec.describe GameComplete do
  let(:game) { Game.create!(word: 'WORD') }
  let(:game_complete) { GameComplete.new(game) }
  let(:guesses_to_win) { [ 'W', 'O', 'R', 'D' ] }
  let(:guesses_to_lose) { [ 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'A', 'S' ] }

  describe '#result' do
    subject { game_complete.result }

    it { is_expected.to be_a_kind_of(Symbol) }

    context 'with a new game with no bad guesses' do
      it { is_expected.to be :running }
    end

    context 'with a new game with one bad guess' do
      before do
        ['A'].each { |letter| game.guesses.create!(letter: letter) }
      end

      it { is_expected.to be :running }
    end

    context 'with a new game with one correct guess' do
      before do
        ['O'].each { |letter| game.guesses.create!(letter: letter) }
      end

      it { is_expected.to be :running }
    end

    context 'with a new game with the word all guessed' do
      before do
        guesses_to_win.each { |letter| game.guesses.create!(letter: letter) }
      end

      it { is_expected.to be :won }
    end

    context 'with a new game with all lives used up' do
      before do
        guesses_to_lose.each { |letter| game.guesses.create!(letter: letter) }
      end

      it { is_expected.to be :lost }
    end
  end

  describe '#call' do
    subject { game_complete.call }

    it { is_expected.to be_a_kind_of(TrueClass).or be_a_kind_of(FalseClass) }

    context 'with a new game with no bad guesses' do
      it { is_expected.to be false }
    end

    context 'with a new game with one bad guess' do
      before do
        ['A'].each { |letter| game.guesses.create!(letter: letter) }
      end

      it { is_expected.to be false }
    end

    context 'with a new game with one correct guess' do
      before do
        ['O'].each { |letter| game.guesses.create!(letter: letter) }
      end

      it { is_expected.to be false }
    end

    context 'with a new game with the word all guessed' do
      before do
        guesses_to_win.each { |letter| game.guesses.create!(letter: letter) }
      end

      it { is_expected.to be true }
    end

    context 'with a new game with all lives used up' do
      before do
        guesses_to_lose.each { |letter| game.guesses.create!(letter: letter) }
      end

      it { is_expected.to be true }
    end
  end
end
