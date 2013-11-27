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
			run Rack::Directory.new(dir)
		end
	end
end
