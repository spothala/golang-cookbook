use_inline_resources

action :create do
    t = template "/etc/init/#{new_resource.name}.conf" do
        source '/etc/init/hook.conf.erb'
        cookbook 'golang'
        owner 'root'
        group 'root'
        mode '0644'
        variables(
            :name => new_resource.name,
            :port => new_resource.port,
            :conf_dir => new_resource.conf_dir,
            :log => new_resource.log_dir+new_resource.name+".log"
        )
        notifies :restart, "service[#{new_resource.name}]"
    end
    link "/etc/init.d/#{new_resource.name}" do
        to "/lib/init/upstart-job"
    end
    service "#{new_resource.name}" do
        provider Chef::Provider::Service::Upstart
        action [:enable, :start]
    end

    new_resource.updated_by_last_action(t.updated_by_last_action?)
end
