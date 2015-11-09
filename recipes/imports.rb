#
# Cookbook Name:: golang
# Recipe:: packages
#

include_recipe 'golang'

node['go']['dependencies'].each do |pkg|
  package pkg
end

node['go']['imports'].each do |import|
  golang_import import
end
