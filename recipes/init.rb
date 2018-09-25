
template '/etc/systemd/system/mailhog.service' do
  source 'mailhog.unit.erb'
  owner node['mailhog']['service']['owner']
  group node['mailhog']['service']['group']
  mode 0644
  variables(
    :binary => node['mailhog']['binary']['path'],
    :opts => node['mailhog']['opts']
  )
  notifies :restart, 'service[mailhog]'
end

service 'mailhog' do
  supports [:start]
  # starts the service if it's not running and enables it to start at system boot time
  action [:enable, :start]
end
