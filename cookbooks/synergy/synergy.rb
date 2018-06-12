if  ENV['USER'] != 'root'
  Itamae.logger.error "this need to be done as root: sudo"
  exit 1
end

url = 'http://ftp.us.debian.org/debian/pool/main/s/synergy/synergy_1.8.8-stable+dfsg.1-1_armhf.deb'
filename = File.basename(url)

execute 'download synergy' do
  cwd '/tmp'
  command "curl -O #{url}"
  not_if "test -e /tmp/#{filename}"
end

execute 'install synergy' do
  "apt install /tmp/#{filename} -yq"  
  not_if "test -e /usr/bin/synergyc"
end

template '/usr/local/bin/synergyc-launcher' do 
  source 'files/synergyc-launcher.sh' 
  mode '755'
end

# add following to /home/pi/.config/lxsession/LXDE-pi/autostart
# @lxterminal -e /usr/local/bin/synergyc-launcher
