#
# Cookbook:: jenkins
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

file 'test.txt' do
  content 'testing pipeline'
  action :create
  owner 'root'
  group 'root'
  mode '0644'
end

file 'final.txt' do
  action :create
  owner 'root'
  group 'root'
  mode '0644'
  content "this isn't fun anymore"
end
