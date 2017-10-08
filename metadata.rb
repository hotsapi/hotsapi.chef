name              'hotsapi'
maintainer        'Poma'
maintainer_email  'Semenov.Roman@mail.ru'
license           'All Rights Reserved'
description       'Installs/Configures hotsapi'
long_description  'Installs/Configures hotsapi'

version           '0.1.6'
chef_version      '>= 12.1' if respond_to?(:chef_version)

depends 'apt'
depends 'cloudwatch-logs'
depends 'cloudwatch_monitoring'
#depends 'supervisor'