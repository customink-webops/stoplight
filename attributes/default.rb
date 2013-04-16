default['stoplight']['install_dir'] = '/opt'
default['stoplight']['servers'] = [
  {
    'name' => 'stoplight',
    'apache' => {
      'server_name' => 'stoplight.localhost',
      'server_admin' => 'admin@localhost',
      'port' => '80'
    },
    'servers' => [
      {
        'type' => 'travis',
        'url' => 'http://travis-ci.org'
      },
      {
        'type' => 'jenkins',
        'url' => 'http://ci.jenkins-ci.org'
      }
    ]
  }
]

default['stoplight']['repo'] = 'git://github.com/customink/stoplight.git'
default['stoplight']['revision'] = 'master'

