class LetterHasBeenGuessed
  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    @game.guesses.pluck(:letter).include? @letter
  end
end

#TODO delete this and think about it
#foo = :foo
#
#&foo
#
#foo.to_proc
#
#class Symbol
#  def to_proc
#    return Proc.new do |object|
#      object.send(self)
#    end
#  end
#end

