if  ENV['USER'] != 'root'
  Itamae.logger.error "ngrok/default: installs ngrok in /usr/local/bin - run as root - try adding sudo"
  exit 1
end

execute 'download ngrok for arm' do
  cwd '/tmp'
  command 'curl -O https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip'
  not_if 'test -e /tmp/ngrok-stable-linux-arm.zip'
end

execute 'unzip ngrok' do
  cwd '/usr/local/bin'
  command 'unzip /tmp/ngrok-stable-linux-arm.zip'
  not_if 'test -e /usr/local/bin/ngrok'
  only_if 'test -e /tmp/ngrok-stable-linux-arm.zip'
end
