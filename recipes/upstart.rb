include_recipe "golang"

case node["platform"]
  when 'ubuntu'
    golang_upstart "gaehook" do
      port 8080
      conf_dir "/etc/hook/conf/"
      log_dir "/var/log/"
    end
  when 'centos'
    #Fill the code here
  end
