maintainer       "CustomInk, LLC"
maintainer_email "svargo@customink.com"
license          "Apache 2.0"
description      "Installs/Configures Stoplight"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

depends "git"

recipe "default", "Installs, configures, and runs a Stoplight application."

attribute "install_dir",
  :display_name => "Stoplight Installation Directory",
  :description => "Location where the Stoplight application will run",
  :default => "/opt"

attribute "servers",
  :display_name => "Servers",
  :description => "An array of Stoplight configuration instances",
  :default => "A single Stoplight configuration"

attribute "servers[name]",
  :display_name => "Stoplight Name",
  :description => "The name of this Stoplight",
  :default => "stoplight"

attribute "servers[port]",
  :display_name => "Stoplight Port",
  :description => "The port used by this Stoplight",
  :default => "4567"

attribute "servers[servers]",
  :display_name => "Servers",
  :description => "An array of servers (providers) that this Stoplight should watch",
  :default => "Travis CI and Jenkins CI"

attribute "servers[servers][url]",
  :display_name => "Server URL",
  :description => "The URL for this build server",
  :default => "http://travis-ci.org/repositories.json"

attribute "servers[servers][username]",
  :display_name => "Server Username",
  :description => "The login for this server (optional)"

attribute "servers[servers][password]",
  :display_name => "Server Password",
  :description => "The password for this server (optional)"

attribute "servers[servers][projects]",
  :display_name => "Server Projects to Watch",
  :description => "Array of jobs to poll for.  Leave empty to watch all projects"

attribute "servers[servers][ignored_projects]",
  :display_name => "Server Projects to Ignore",
  :description => "Array of projects to ignore.  Leave empty to watch all projects"
