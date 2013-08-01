python_pip "carbon" do
  version node["graphite"]["version"]
  options %Q{--install-option="--prefix=#{node['graphite']['home']}" --install-option="--install-lib=#{node['graphite']['home']}/lib"}
  action :install
end

python_pip "zope.interface" do
  action :install
end

# if we listen on all IPs, send it to loopback
if node["graphite"]["carbon"]["pickle_receiver_interface"] == "0.0.0.0"
  ip = "127.0.0.1"
else
  ip = node["graphite"]["carbon"]["pickle_receiver_interface"]
end

# come up with list of destinations relay needs to send to
destinations = []
node["graphite"]["carbon"]["instances"].each do |instance, value|
  destinations << "#{ip}:#{value['pickle_receiver_port']}:#{instance}"
end

template "#{node['graphite']['home']}/conf/carbon.conf" do
  mode "0644"
  source "carbon.conf.erb"
  owner node["apache"]["user"]
  group node["apache"]["group"]
  variables(
    :whisper_dir                => node["graphite"]["carbon"]["whisper_dir"],
    :line_receiver_interface    => node["graphite"]["carbon"]["line_receiver_interface"],
    :pickle_receiver_interface  => node["graphite"]["carbon"]["pickle_receiver_interface"],
    :cache_query_interface      => node["graphite"]["carbon"]["cache_query_interface"],
    :log_updates                => node["graphite"]["carbon"]["log_updates"],
    :instances                  => node["graphite"]["carbon"]["instances"],
    :relay                      => node["graphite"]["carbon"]["relay"],
    :destinations               => destinations.join(",")
  )
end

template "#{node['graphite']['home']}/conf/storage-schemas.conf" do
  mode "0644"
  source "storage-schemas.conf.erb"
  owner node["apache"]["user"]
  group node["apache"]["group"]
end

template "#{node['graphite']['home']}/conf/storage-aggregation.conf" do
  mode "0644"
  source "storage-aggregation.conf.erb"
  owner node["apache"]["user"]
  group node["apache"]["group"]
end

execute "chown" do
  command "chown -R #{node["apache"]["user"]}:#{node["apache"]["group"]} #{node['graphite']['home']}/storage"
  only_if do
    f = File.stat("#{node['graphite']['home']}/storage")
    f.uid == 0 && f.gid == 0
  end
end

# need to configure upstart for carbon-relay
template "/etc/init/carbon-relay.conf" do
  mode "0644"
  source "carbon-relay.conf.erb"
  variables(
    :home => node["graphite"]["home"],
    :version => node["graphite"]["version"],
  )
end

service "carbon-relay" do
  provider Chef::Provider::Service::Upstart
  action [ :enable, :start ]
  subscribes :restart, "template \"#{node['graphite']['home']}/conf/carbon.conf\"", :delayed
end

node["graphite"]["carbon"]["instances"].each do |instance, value|
  template "/etc/init/carbon-cache-#{instance}.conf" do
    mode "0644"
    source "carbon-cache.conf.erb"
    variables(
      :home => node["graphite"]["home"],
      :version => node["graphite"]["version"],
      :instance => instance
    )
  end

  logrotate_app "carbon-cache-#{instance}" do
    cookbook "logrotate"
    path "#{node['graphite']['home']}/storage/log/carbon-cache/carbon-cache-#{instance}/*.log"
    frequency "daily"
    rotate 7
    create "644 root root"
  end

  service "carbon-cache-#{instance}" do
    provider Chef::Provider::Service::Upstart
    action [ :enable, :start ]
    subscribes :restart, "template \"#{node['graphite']['home']}/conf/carbon.conf\"", :delayed
    subscribes :restart, "template \"#{node['graphite']['home']}/conf/storage-schemas.conf\"", :delayed
    subscribes :restart, "template \"#{node['graphite']['home']}/conf/storage-aggregation.conf\"", :delayed
  end
end