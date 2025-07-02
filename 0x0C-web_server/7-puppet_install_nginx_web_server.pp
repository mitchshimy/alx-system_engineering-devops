# 7-puppet_install_nginx_web_server.pp
# Puppet manifest to install Nginx, serve Hello World, and set up a 301 redirect

# Ensure nginx is installed and running
package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
}

# Custom index.html with Hello World!
file { '/var/www/html/index.nginx-debian.html':
  ensure  => file,
  content => "Hello World!\n",
  require => Package['nginx'],
}

# Create custom nginx config with redirect
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default_redirect.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}
