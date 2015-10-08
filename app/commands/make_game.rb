class MakeGame
  def initialize
  end

  def call
    Game.create!(word: 'WORD')
  end
end
