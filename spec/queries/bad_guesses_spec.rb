require 'rails_helper'

RSpec.describe BadGuesses do
  let(:game) { Game.create!(word: 'WORD') }
  let(:bad_guesses) { BadGuesses.new(game) }
  subject { bad_guesses.call }

  it { is_expected.to be_a_kind_of(Array) }

  context 'with a new game with no bad guesses' do
    it { is_expected.to eq([]) }
  end

  context 'with a new game with one bad guess' do
    before do
      # TODO: refactor without .each
      # TODO: use :good_guess and :bad_guess
      ['A'].each { |letter| game.guesses.create!(letter: letter) }
    end

    it { is_expected.to eq(['A']) }
  end

  context 'with a new game with one correct guess' do
    before do
      ['O'].each { |letter| game.guesses.create!(letter: letter) }
    end

    it { is_expected.to eq([]) }
  end
end
