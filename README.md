# Redmine Quick Links
A plugin for Redmine which adds quick links to the welcome page and project overview page.
It allows quick access to URLs not only for places inside Redmine but also für external sites.
For example you can use it to give your users a direct link to a prefilled issue form to file a new bug or create a todo.
Or you have a special project help page and you would like to help your project members finding it. One can restrict the access to links by project membership and roles so every user gets just the links he needs. 
![Welcome page view](screenshots/welcome-page.png)

# How it works
The Quick Links plugin adds a new view to Redmine's administration panel. On this view all your created links are listed and you can sort them to your needs. You can also edit or delete existing links on this view. To create a new Link click on "New link" in the contexual menu section.

![Admin panel view](screenshots/admin-panel.png)

The form fields are:

- **Label** The label which is shown quick link boxes.
- **Description** A descrptive text which is shown as tooltip.
- **URL** The specific URL (internal or external) the Link should point to.
- **Project** Select a project if the link should only visible to project members. If a project is selected the link is also shown on the projects overview page.
- **Role** Restrict the access to the link to a specific role. (e.g. special Gantt queries only for managers)
- **icon-class** If you would like to show an icon next to your link you can specify the CSS class here.


# How to install the plugin

The necessary steps are:
1. Clone the Github repository to your Redmine's plugin folder.
1. Execute a plugin migration with `bundle exec rake redmine:plugins:migrate RAILS_ENV=production`

 
