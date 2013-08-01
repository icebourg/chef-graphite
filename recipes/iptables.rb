# handle iptables stuff

include_recipe "iptables"

iptables_rule "graphite" do
  variables(
    :ip_addresses  => node[:graphite][:ip_addresses].values.flatten
  ) 
end
