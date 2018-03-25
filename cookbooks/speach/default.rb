package 'espeak'
package 'festival'

template "/usr/local/bin/say" do
    source "bin/say"
    owner 'pi'
    mode '755'
end
