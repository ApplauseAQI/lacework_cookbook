name             'lacework'
maintainer       'Applause App Quality, Inc.'
maintainer_email 'ops@applause.com'
license          'Apache-2.0'
description      'Installs and configures Lacework'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

%w(redhat centos scientific amazon).each do |os|
  supports os
end

source_url 'https://github.com/ApplauseOSS/lacework_cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/ApplauseOSS/lacework_cookbook/issues' if respond_to?(:issues_url)
chef_version '>= 12.14' if respond_to?(:chef_version)
