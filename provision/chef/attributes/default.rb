default[:magento] = {
  domain: "example.tld",
  docroot: "/var/www/#{node[:magento][:domain]}"
}
