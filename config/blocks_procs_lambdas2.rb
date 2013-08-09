blocks
procs -have to be called, as many arguments as you want, saved in a variable
lambdas -have to be called, specific number of arguments and they complain

name = "mary"
proc = {name}

Proc.new do |name|
	name.reverse
end

Proc.new {|name| name.reverse; name.bytes}

lambda {|name| name.reverse} 

brad -> {|name| name.reverse}

[1,3].each {|num| puts num}

