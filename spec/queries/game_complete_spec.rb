require 'rails_helper'

RSpec.describe GameComplete do
  let(:game) { Game.create!(word: 'WORD') }
  let(:game_complete) { GameComplete.new(game) }
  let(:guesses_to_win) { [ 'W', 'O', 'R', 'D' ] }
  let(:guesses_to_lose) { [ 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'A', 'S' ] }
  subject { game_complete.call }

  it { is_expected.to be_a_kind_of(Hash) }

  context 'with a new game with no bad guesses' do
    it { is_expected.to include(finished: false) }
  end

  context 'with a new game with one bad guess' do
    before do
      ['A'].each { |letter| game.guesses.create!(letter: letter) }
    end

    it { is_expected.to include(finished: false) }
  end

  context 'with a new game with one correct guess' do
    before do
      ['O'].each { |letter| game.guesses.create!(letter: letter) }
    end

    it { is_expected.to include(finished: false) }
  end

  context 'with a new game with the word all guessed' do
    before do
      guesses_to_win.each { |letter| game.guesses.create!(letter: letter) }
    end

    it { is_expected.to include(finished: true) }
    it { is_expected.to include(status: :won) }
  end

  context 'with a new game with all lives used up' do
    before do
      guesses_to_lose.each { |letter| game.guesses.create!(letter: letter) }
    end

    it { is_expected.to include(finished: true) }
    it { is_expected.to include(status: :lost) }
  end
end
