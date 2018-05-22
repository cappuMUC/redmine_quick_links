module RedmineQuickLinks
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_welcome_index_right,
      :partial => 'quick_links/quick_link_box'
  end
end
