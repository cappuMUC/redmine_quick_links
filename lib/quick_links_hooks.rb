module RedmineQuickLinks
  class Hooks < Redmine::Hook::ViewListener

    def view_welcome_index_right( context = {})
      if User.current.logged?
        context[:show_project_headings] = true
        collect_global_links_for_context(context)
        collect_global_project_links_for_context(context)
        if context_has_links_to_show?(context)
          context[:controller].send(
          :render_to_string, {
            :partial => 'quick_links/quick_link_box',
            :locals => context
            })
          end
        end
      end

      def view_projects_show_right( context = {})
        if User.current.logged? && User.current.membership(context[:project])
          context[:show_project_headings] = false
          context[:public_links] = []
          context[:project_links] = []
          collect_project_links_for_context(context)
          if context_has_links_to_show?(context)
            context[:controller].send(
            :render_to_string, {
              :partial => 'quick_links/quick_link_box',
              :locals => context
              })
            end
          end
        end

      private

      def collect_global_links_for_context(context)
        public_links = QuickLink.where( :project_id => nil, :role_id => nil )
        context[:public_links] = public_links.sort_by{|e| e[:position]}
      end

      def collect_project_links_for_context(context)
        project_links = []
        roles = User.current.membership(context[:project]).roles.to_a
        project_links.concat QuickLink.where( :project_id => context[:project], :role_id => roles )
        project_links.concat QuickLink.where( :project_id => context[:project], :role_id => nil )
        context[:project_links] = project_links.sort_by{|e| e[:position]}
      end

      def collect_global_project_links_for_context(context)
        project_links = []
        User.current.project_ids.each do |project|
          roles = User.current.membership(project).roles.to_a
          project_links.concat QuickLink.where( :project_id => project, :role_id => roles )
          project_links.concat QuickLink.where( :project_id => project, :role_id => nil )
        end
        context[:project_links] = project_links.sort_by{|e| e[:position]}
      end

      def context_has_links_to_show?(context)
        context[:public_links].any? || context[:project_links].any?
      end

    end
  end
