# now let's backup our crap
cookbook_file "/usr/local/bin/graphite-archive.sh" do
  source "graphite-archive.sh"
  mode 0755
  owner "root"
  group "root"
end

# and add it to cron
cron "graphite-archive" do
  hour "3"
  minute "18"
  command "/usr/local/bin/graphite-archive.sh"
end

# for where we store backups
directory "/var/lib/graphite-archive" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end