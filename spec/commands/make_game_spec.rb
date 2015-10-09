require 'rails_helper'

RSpec.describe MakeGame do
  let(:make_game) { MakeGame.new }
  subject { make_game.call }

  it 'makes a new game' do
    expect{make_game.call}.to change{Game.count}.by(1)
  end

  it 'makes games with random words' do
    game1 = MakeGame.new.call
    game2 = MakeGame.new.call
    game3 = MakeGame.new.call

    expect(game1.word).to_not eq(game2.word) or eq(game3.word)
  end
end
