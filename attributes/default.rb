default['stoplight']['install_dir'] = '/opt'
default['stoplight']['servers'] = [
  {
    'name' => 'stoplight',
    'port' => '4567',
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
