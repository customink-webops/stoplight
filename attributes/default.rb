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
        'url' => 'http://travis-ci.org/repositories.json'
      },
      {
        'type' => 'jenkins',
        'url' => 'http://ci.jenkins-ci.org/cc.xml'
      }
    ]
  }
]
