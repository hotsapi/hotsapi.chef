default['hotsapi']['install_mysql'] = false

default['cwlogs']['region'] = 'eu-west-1'

default['cwlogs']['logfiles']['access-log'] = {
  :log_stream_name  => '{instance_id}',
  :log_group_name   => 'nginx/access.log',
  :file             => '/var/log/nginx/access.log',
  :datetime_format  => '[%d/%m/%Y:%H:%M:%S +0300]',
  :initial_position => 'end_of_file'
}

default['cwlogs']['logfiles']['error-log'] = {
  :log_stream_name  => '{instance_id}',
  :log_group_name   => 'nginx/error.log',
  :file             => '/var/log/nginx/error.log',
  :datetime_format  => '[%d/%m/%Y:%H:%M:%S +0300]',
  :initial_position => 'end_of_file'
}

default['cwlogs']['logfiles']['laravel-log'] = {
  :log_stream_name          => '{instance_id}',
  :log_group_name           => 'laravel/laravel.log',
  :file                     => '/var/www/hotsapi/storage/logs/laravel.log',
  :datetime_format          => '[%Y-%m-%d %H:%M:%S]',
  :multi_line_start_pattern => '{datetime_format}',
  :initial_position         => 'end_of_file'
}

default['cwlogs']['logfiles']['worker-log'] = {
  :log_stream_name          => '{instance_id}',
  :log_group_name           => 'laravel/worker.log',
  :file                     => '/var/www/hotsapi/storage/logs/worker.log',
  :datetime_format          => '[%Y-%m-%d %H:%M:%S]',
  :multi_line_start_pattern => '{datetime_format}',
  :initial_position         => 'end_of_file'
}

default['cwlogs']['logfiles']['parser-log'] = {
  :log_stream_name          => '{instance_id}',
  :log_group_name           => 'laravel/parser.log',
  :file                     => '/var/www/hotsapi/storage/logs/parser.log',
  :multi_line_start_pattern => '^(Error parsing file|Parsing replay)',
  :initial_position         => 'end_of_file'
}