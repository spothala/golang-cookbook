actions :create
default_action :create

attribute(:name, kind_of: String)
attribute(:port, kind_of: Integer)
attribute(:conf_dir, kind_of: String)
attribute(:log_dir, kind_of: String)
