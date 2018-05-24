module RedmineQuickLinks
  class Hooks < Redmine::Hook::ViewListener
    def view_welcome_index_right( context = {})
      if User.current.logged? && has_links_to_show?(context)
        context[:controller].send(
          :render_to_string, {
          :partial => 'quick_links/quick_link_box',
          :locals => context
        })
      end
    end

    private
    def has_links_to_show?(context)
      project_links = []
      User.current.project_ids.each do |project|
        roles = User.current.membership(project).roles.to_a
        project_links.concat QuickLink.where( :project_id => project, :role_id => roles )
      end
      context[:project_links] = project_links
      context[:public_links] = QuickLink.where( :project_id => 0, :role_id => 0 )
      context[:public_links].any? || context[:project_links].any?
    end
  end
end
