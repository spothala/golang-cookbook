#
# Cookbook Name:: golang
# Recipe:: default
#
node.default['go']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
node.default['go']['filename'] = "go#{node['go']['version']}.#{node['os']}-#{node['go']['platform']}.tar.gz"
node.default['go']['url'] = "https://golang.org/dl/#{node['go']['filename']}"

remote_file File.join(Chef::Config[:file_cache_path], node['go']['filename']) do
    source node['go']['url']
    backup false
    owner 'root'
    mode 0644
    notifies :run, 'bash[install-golang]', :immediately
    #not_if "#{node['go']['install_location']}/go/bin/go version | grep \"go#{node['go']['version']}\""
end

bash "install-golang" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOF
      rm -rf go
      rm -rf #{node['go']['install_location']}/go
      tar -C #{node['go']['install_location']} -xzf #{node['go']['filename']}
    EOF
end

%w{ node['go']['gopath'] node['go']['gobin'] }.each do |godir|
  directory "#{godir}" do
    action :create
    recursive true
    owner node['go']['owner']
    group node['go']['group']
    mode node['go']['mode']
  end
end

template "/etc/profile.d/golang.sh" do
  source "golang.sh.erb"
  owner 'root'
  group 'root'
  mode 0755
end
