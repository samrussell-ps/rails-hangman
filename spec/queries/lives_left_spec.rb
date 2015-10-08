require 'rails_helper'

RSpec.describe LivesLeft do
  let(:game) { Game.create!(word: 'WORD') }
  let(:lives_left) { LivesLeft.new(game) }
  let(:initial_lives) { 9 }
  subject { lives_left.call }

  it { is_expected.to be_a_kind_of(Integer) }

  context 'with a new game with no bad guesses' do
    it { is_expected.to eq(9) }
  end

  context 'with a new game with one bad guess' do
    before do
      ['A'].each { |letter| game.guesses.create!(letter: letter) }
    end

    it { is_expected.to eq(8) }
  end

  context 'with a new game with one correct guess' do
    before do
      ['O'].each { |letter| game.guesses.create!(letter: letter) }
    end

    it { is_expected.to eq(9) }
  end
end
