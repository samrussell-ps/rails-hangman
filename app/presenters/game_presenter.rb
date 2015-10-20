class GamePresenter
  GAME_STATUS_MESSAGE = {
    won: "Congratulations, you won! The word was %{word}",
    lost: "You lost :( The word was %{word}"
  }

  GAME_STATUS_CLASS = {
    won: 'alert alert-success',
    lost: 'alert alert-info'
  }

  def initialize(game, template)
    @game = game
    @template = template
  end

  def render_alert
    #TODO use helpers for content_tag
    if @template.flash[:alert]
      @template.content_tag(:div, @template.flash[:alert], class: 'alert alert-danger')
    end
  end

  def render_game_status
    if GameComplete.new(@game).call
      @template.content_tag(:div, status_message(game_status), class: status_class(game_status))
    end
  end

  def render_game_info
    render_word_progress

    render_bad_guesses

    render_lives_left
  end

  private

  def status_message(status)
    GAME_STATUS_MESSAGE[status] % { word: @game.word }
  end

  def status_class(status)
    GAME_STATUS_CLASS[status]
  end

  def render_word_progress
    @word_progress = WordProgress.new(@game).call
    word_progress_print = @word_progress.map { |char| char ? char : '_'}.join ' '
    @template.content_tag(:p, word_progress_print)
  end

  def render_bad_guesses
    @bad_guesses = BadGuesses.new(@game).call
    @template.content_tag(:p, @bad_guesses.join(' '))
  end

  def render_lives_left
    @lives_left = LivesLeft.new(@game).call
    @template.content_tag(:p, "Lives left:#{@lives_left}") 
  end

  def game_status
    GameComplete.new(@game).result
  end
end
