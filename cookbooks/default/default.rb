# fix keyboard to be US

template "/etc/default/keyboard" do
  source "templates/default.keyboard"
  owner 'root'
  group 'root'
  mode '0664'
end


