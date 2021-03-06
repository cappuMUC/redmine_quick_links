require_dependency 'quick_links_hooks'

Redmine::Plugin.register :redmine_quick_links do
  name 'Redmine Quick Links plugin'
  author 'Bernhard Rohloff'
  description 'Shows custom links for users based on projects and roles'
  version '0.0.1'
  url 'https://github.com/cappumuc/redmine_quick_links'
  author_url ''


  menu :admin_menu,
    :shortcuts,
    { :controller => 'quick_links' },
    :caption => "Quick Links",
    :after => :enumerations,
    :html => { :class => 'icon icon-summary' }
end
