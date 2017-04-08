#
# Cookbook Name:: magento
# Recipe:: structure
#

docroot = node[:magento][:docroot]

dirs = %(
  releases
  shared
  shared/app
  shared/app/etc
  shared/composer
  shared/pub
  shared/pub/static
  shared/pub/media
  shared/var
)

directory docroot do
  owner     "www-data"
  group     "www-data"
  mode      0755
  recusrive true
  action    :create
end

dirs.each do |dir|
  directory "#{docroot}/#{dir}" do
    owner     "www-data"
    group     "www-data"
    mode      0755
    recursive true
    action :create
  end
end
