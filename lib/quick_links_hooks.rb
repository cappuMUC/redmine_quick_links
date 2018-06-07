module RedmineQuickLinks
  class Hooks < Redmine::Hook::ViewListener

    def view_welcome_index_right( context = {})
      if User.current.logged?
        collect_global_links_for_context(context)
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
