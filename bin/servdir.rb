#!/usr/bin/env ruby
#
# Serves a directory over HTTP
# The main purpose of this script is to temporarily serve videos
# for streaming.  Just hit <ctrl-c> to exit.

require 'webrick'
require 'optparse'

class Servdir
	def initialize
		options = {}
		opts = OptionParser.new do |opts|
			opts.banner =  "\nUse Webrick to serve a directory or a file over HTTP \n
	Usage: servdir.rb <-d dir> [-p port]"
			opts.separator ""
			opts.separator "Options:"

			opts.on("-d <dir>", "--directory <dir>", String,
				"The directory you want to serve.  
					You can also serve a single file.") do |d|
					options[:dir] = d
			end
				
			opts.on("-p <port>", "--port <port>", String,
				"Port number, default is 2000") do |p|
					options[:port] = p.to_i
			end

			opts.on_tail("-h", "--help", "Show this message") do
				puts opts
				exit
			end
		end	
		begin
			opts.parse(ARGV)
		rescue OptionParser::MissingArgument, OptionParser::InvalidOption
		end

		if options.has_key?(:dir)
			@dir = options[:dir]
		else
			@dir = ENV['PWD']
		end

		if options.has_key?(:port)
			@port = options[:port]
		else
			@port = 2000
		end
	end

	def serve
		s = WEBrick::HTTPServer.new(
			:Port => @port,
			:DocumentRoot => @dir,
            :FancyIndexing => true
    		)
		trap("INT"){ s.shutdown }
		s.start
	end
end

s = Servdir.new
s.serve
