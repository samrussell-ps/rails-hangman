class KeyboardPresenter
  KEYBOARD_ROWS = [
    %w[Q W E R T Y U I O P],
    %w[A S D F G H J K L],
    %w[Z X C V B N M]
  ]

  def initialize(template)
    @template = template
  end

  def letter(letter)
    @template.content_tag(:li, @template.content_tag(:span, letter), class: 'letter')
  end

  def row(index)
    KEYBOARD_ROWS[index]
  end
end
