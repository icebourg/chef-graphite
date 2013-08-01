default["graphite"]["version"]                              = "0.9.10"
default["graphite"]["home"]                                 = "/opt/graphite"
default["graphite"]["carbon"]["line_receiver_interface"]    = "127.0.0.1"
default["graphite"]["carbon"]["pickle_receiver_interface"]  = "127.0.0.1"
default["graphite"]["carbon"]["cache_query_interface"]      = "127.0.0.1"
default["graphite"]["carbon"]["log_updates"]                = true
default["graphite"]["carbon"]["whisper_dir"]                = "#{node["graphite"]["home"]}/storage/whisper"
default["graphite"]["dashboard"]["timezone"]                = "America/New_York"
default["graphite"]["dashboard"]["memcache_hosts"]          = [ "127.0.0.1:11211" ]

# The default values template
default["graphite"]["templates"]["default"]["background"]   = "black"
default["graphite"]["templates"]["default"]["foreground"]   = "white"
default["graphite"]["templates"]["default"]["majorLine"]    = "white"
default["graphite"]["templates"]["default"]["minorLine"]    = "grey"
default["graphite"]["templates"]["default"]["lineColors"]   = "blue,green,red,purple,brown,yellow,aqua,grey,magenta,pink,gold,rose"
default["graphite"]["templates"]["default"]["fontName"]     = "Sans"
default["graphite"]["templates"]["default"]["fontSize"]     = "10"
default["graphite"]["templates"]["default"]["fontBold"]     = "False"
default["graphite"]["templates"]["default"]["fontItalic"]   = "False"

#Storage Schemas
default["graphite"]["storage_schemas"] = [
  {
    :stats => {
      :priority   => "100",
      :pattern    => "^stats\\..*",
      :retentions => "10s:7d,1m:31d,10m:5y"
    }
  },
  {
    :catchall => {
      :priority   => "0",
      :pattern    => "^.*",
      :retentions => "60s:5y"
    }
  }
]

#Storage Aggregation
default["graphite"]["storage_aggregation"] = [
  {
    :min => {
      :pattern            => "\\.min$",
      :xFilesFactor       => "0.1",
      :aggregationMethod  => "min"
    }
  },
  {
    :max => {
      :pattern            => "\\.max$",
      :xFilesFactor       => "0.1",
      :aggregationMethod  => "max"
    }
  },
  {
    :sum => {
      :pattern            => "\\.count$",
      :xFilesFactor       => "0",
      :aggregationMethod  => "sum"
    }
  },
  {
    :default_average => {
      :pattern            => ".*",
      :xFilesFactor       => "0.3",
      :aggregationMethod  => "average"
    }
  }
]

# what IPs we want to allow ...  not stoked about doing it this way but until we have one chef server to rule them all...
default[:graphite][:ip_addresses][:anaheim]   = ["174.127.33.234"]
default[:graphite][:ip_addresses][:boulder]   = ["207.174.117.42/32",
   "206.124.12.82/32"]
default[:graphite][:ip_addresses][:denver]    = ["68.64.217.58"]
default[:graphite][:ip_addresses][:limestone] = ["208.115.214.0/24",
  "208.115.235.0/24", "74.63.231.0/24", "74.63.233.0/24", "74.63.233.0/24",
  "74.63.235.0/24", "74.63.234.0/24", "74.63.236.0/24", "74.63.247.0/24",
  "69.162.98.0/24", "74.63.194.0/24", "74.63.249.216/29", "208.115.232.80/29",
  "64.31.13.24/29", "74.63.197.176/29", "69.162.119.168/29",
  "69.162.105.144/29"]
default[:graphite][:ip_addresses][:steadfast] = ["50.31.32.0/19",
  "208.117.48.0/20", "67.202.80.0/22"]
default[:graphite][:ip_addresses][:sendgrid]  = ["198.37.144.0/20"]
default[:graphite][:ip_addresses][:softlayer] = [ "37.58.82.160/29",
                                                  "50.22.57.64/27",
                                                  "50.23.224.104/29",
                                                  "50.97.69.144/28",
                                                  "50.97.70.224/27",
                                                  "50.97.228.128/27",
                                                  "67.228.60.0/27",
                                                  "75.126.49.208/28",
                                                  "173.192.31.32/27",
                                                  "173.192.42.192/27",
                                                  "173.193.186.0/27",
                                                  "174.36.92.8/29",
                                                  "174.37.65.0/27",
                                                  "174.37.77.192/27",
                                                  "174.37.189.192/27",
                                                  "37.58.81.0/29",
                                                  "37.58.84.176/28",
                                                  "50.22.7.160/27",
                                                  "67.228.32.0/27",
                                                  "74.86.4.128/28",
                                                  "74.86.7.96/29",
                                                  "75.126.100.64/26",
                                                  "108.168.211.0/27",
                                                  "173.193.154.64/26",
                                                  "173.193.154.128/26",
                                                  "174.36.68.184/29",
                                                  "50.23.143.96/27",
                                                  "67.228.50.32/27",
                                                  "75.126.200.128/27",
                                                  "75.126.253.0/24",
                                                  "86.124.171.221",
                                                  "159.253.152.236/30",
                                                  "173.192.31.39",
                                                  "173.192.90.240/29",
                                                  "174.36.32.192/27",
                                                  "174.36.80.208/28",
                                                  "174.36.92.96/27",
                                                  "174.37.35.0/29",
                                                  "184.173.74.236/30",
                                                  "184.173.109.232/29",
                                                  "173.192.90.152/29",
                                                  "173.193.132.0/24",
                                                  "173.193.133.0/24",
                                                  "50.23.146.40/30",
                                                  "50.23.154.212/30",
                                                  "66.228.125.8/29",
                                                  "67.228.2.72/30",
                                                  "67.228.31.232/30",
                                                  "67.228.46.84/30",
                                                  "67.228.78.220/30",
                                                  "67.228.169.24/30",
                                                  "67.228.172.48/30",
                                                  "67.228.173.212/30",
                                                  "74.86.12.172/30",
                                                  "74.86.14.24/30",
                                                  "74.86.23.72/30",
                                                  "74.86.82.24/30",
                                                  "74.86.114.168/30",
                                                  "74.86.163.56/30",
                                                  "74.86.168.180/30",
                                                  "74.86.189.188/30",
                                                  "74.86.235.224/30",
                                                  "75.126.128.244/30",
                                                  "75.126.129.176/30",
                                                  "75.126.131.140/30",
                                                  "75.126.139.240/30",
                                                  "75.126.165.188/30",
                                                  "75.126.166.104/30",
                                                  "173.192.4.4/30",
                                                  "173.192.54.228/30",
                                                  "173.192.61.200/30",
                                                  "173.193.146.172/30",
                                                  "174.36.14.204/30",
                                                  "174.36.60.156/30",
                                                  "174.36.84.176/30",
                                                  "174.36.96.240/30",
                                                  "174.36.96.244/30",
                                                  "174.36.104.239/32",
                                                  "174.37.9.76/30",
                                                  "174.37.14.24/30",
                                                  "174.37.26.4/30",
                                                  "174.37.50.24/30",
                                                  "174.37.73.56/30",
                                                  "174.37.92.232/30",
                                                  "174.37.101.8/30",
                                                  "174.37.123.208/30",
                                                  "174.37.123.212/30",
                                                  "184.173.78.185/32",
                                                  "208.43.22.248/30",
                                                  "208.43.200.24/30"]