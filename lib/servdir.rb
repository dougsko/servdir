#!/usr/bin/env ruby
#
# Serves the files in a folder over HTTP
#

require 'thin'
require 'rack'
require 'socket'

class Servdir
	def initialize(dir, port)
		Thin::Server.start("0.0.0.0", port) do
			#use Rack::CommonLogger
			if File.directory?(dir)
				run Rack::Directory.new(dir)
			elsif File.file?(dir)
				run Rack::File.new(dir)
			end
		end
	end
end
