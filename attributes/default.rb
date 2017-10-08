default['hotsapi']['install_mysql'] = false

default['cwlogs']['region'] = 'eu-west-1'

default['cwlogs']['logfiles']['access-log'] = {
  :log_stream_name  => '{instance_id}',
  :log_group_name   => 'nginx/access.log',
  :file             => '/var/log/nginx/access.log',
  :datetime_format  => '%Y-%m-%d %H:%M:%S',
  :initial_position => 'end_of_file'
}

default['cwlogs']['logfiles']['error-log'] = {
  :log_stream_name  => '{instance_id}',
  :log_group_name   => 'nginx/error.log',
  :file             => '/var/log/nginx/error.log',
  :datetime_format  => '%Y-%m-%d %H:%M:%S',
  :initial_position => 'end_of_file'
}

default['cwlogs']['logfiles']['laravel-log'] = {
  :log_stream_name  => '{instance_id}',
  :log_group_name   => 'laravel/laravel.log',
  :file             => '/var/www/hotsapi/storage/logs/laravel.log',
  :datetime_format  => '%Y-%m-%d %H:%M:%S',
  :initial_position => 'end_of_file'
}

default['cwlogs']['logfiles']['worker-log'] = {
  :log_stream_name  => '{instance_id}',
  :log_group_name   => 'laravel/worker.log',
  :file             => '/var/www/hotsapi/storage/logs/worker.log',
  :datetime_format  => '%Y-%m-%d %H:%M:%S',
  :initial_position => 'end_of_file'
}