default["graphite"]["version"]                              = "0.9.10"
default["graphite"]["home"]                                 = "/opt/graphite"

default["graphite"]["carbon"]["line_receiver_interface"]    = "127.0.0.1"
default["graphite"]["carbon"]["pickle_receiver_interface"]  = "127.0.0.1"
default["graphite"]["carbon"]["cache_query_interface"]      = "127.0.0.1"
default["graphite"]["carbon"]["log_updates"]                = true
default["graphite"]["carbon"]["whisper_dir"]                = "#{node["graphite"]["home"]}/storage/whisper"

default["graphite"]["carbon"]["max_cache_size"]             = "inf"
default["graphite"]["carbon"]["max_updates_per_second"]     = "1000"
default["graphite"]["carbon"]["max_creates_per_minute"]     = "inf"

# relay just relays incoming requests to multiple caches
default["graphite"]["carbon"]["relay"]["line_receiver_port"]  = "2003"
default["graphite"]["carbon"]["relay"]["pickle_receiver_port"]= "2004"
default["graphite"]["carbon"]["relay"]["cache_query_port"]    = "7002"
default["graphite"]["carbon"]["relay"]["relay_method"]        = "consistent-hashing"
default["graphite"]["carbon"]["relay"]["replication_factor"]  = "0"

# we need at least a ... you can add B .. Z if you want
default["graphite"]["carbon"]["instances"]["a"]["line_receiver_port"]  = "2013"
default["graphite"]["carbon"]["instances"]["a"]["pickle_receiver_port"]= "2014"
default["graphite"]["carbon"]["instances"]["a"]["cache_query_port"]    = "7012"

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

# Storage Schemas
# => We'd like to keep carbon data by default. Default for carbon
# instrumentation is 60 seconds. If you change that, change it here too.
default["graphite"]["storage_schemas"] = [
  {
    :carbon => {
      :pattern    => "^carbon\..*",
      :retentions => "60:90d"
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

# what IPs we want to allow access to graphite ports...
# organize this however you please, it gets flattened into a list of IPs
default[:graphite][:ip_addresses][:localhosts]= ["127.0.0.1"]
