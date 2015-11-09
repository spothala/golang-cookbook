default.go.platform = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
default.go.filename = "go#{node['go']['version']}.#{node['os']}-#{node['go']['platform']}.tar.gz"
default.go.url = "https://golang.org/dl/#{node['go']['filename']}"
default.go.install_location = "/usr/local/"
default.go.version = "1.5.1"
default.go.gopath = "/opt/go"
default.go.gobin = "/opt/go/bin"
default.go.owner = "root"
default.go.group = "root"
default.go.mode = 0755

default.go.dependencies = ["git"]
default.go.imports = ["github.com/tools/godep"]

default.go.upstart.port = "8080"
default.go.upstart.conf_dir = "/etc/hook/conf/"
default.go.upstart.log_dir = "/var/log/"
