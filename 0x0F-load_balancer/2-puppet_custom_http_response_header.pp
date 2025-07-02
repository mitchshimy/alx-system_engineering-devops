# Use Puppet to automate the task of creating a custom HTTP header response

exec { 'update':
    provider => shell,
    command  => 'apt-get -y update',
    before   => Exec['install Nginx'],
}

exec { 'install Nginx':
    provider => shell,
    command  => 'apt-get -y install nginx',
    before   => Exec['restart Nginx'],
}

exec { 'restart Nginx':
    provider => shell,
    command  => 'service nginx restart'
}
