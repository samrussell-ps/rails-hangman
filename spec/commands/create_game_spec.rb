require 'rails_helper'

RSpec.describe CreateGame do
  let(:create_game) { CreateGame.new }
  subject { create.call }

  it 'makes a new game' do
    expect{create_game.call}.to change{Game.count}.by(1)
  end

  it 'makes games with random words' do
    game1 = CreateGame.new.call
    game2 = CreateGame.new.call
    game3 = CreateGame.new.call

    expect(game1.word).to_not eq(game2.word) or eq(game3.word)
  end
end
