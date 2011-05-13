#!/usr/bin/env ruby
#
# Serves the files in a folder over HTTP
#

require 'webrick'

class Servdir
    def initialize(dir = ".", port = 2000)
        @dir = dir
        @port = port

        s = WEBrick::HTTPServer.new(
                :Port => @port,
                :DocumentRoot => @dir,
                :FancyIndexing => true
            )
        trap("INT"){ s.shutdown }
        s.start
	end	
end
