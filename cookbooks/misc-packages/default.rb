packages = [ 
	'git',
	'telnet',
	'mplayer',
	'tmux',
	'vim',
	'feh',
	'cmatrix' 
]
packages.each do |p| 
  package p 
end
