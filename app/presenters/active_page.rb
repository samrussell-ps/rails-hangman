class ActivePage
  def initialize(page_name=nil)
    @active_page = page_name
  end

  def [](page_name)
    @active_page == page_name ? ' class="active"'.html_safe : ''
  end
end
