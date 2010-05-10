#!/usr/bin/env ruby
#
# Serves the files in a folder over HTTP
#

require 'rubygems'
require 'webrick'
require 'haml'

class Servdir
    def initialize
        @template_file = 'public/index.haml'
        @template = File.open(@template_file, 'r').read
    end

    def make_html
    haml = 

	def serve(dir, port)
        files = Dir.entries(dir)
        files.each do |file|
            @template << "      %p\n        %a(title='#{dir}'){:href => '#{file}' }'#{file}'\n"
        end
        engine = Haml::Engine.new(@template)
        index_file = engine.render
        index_file.gsub!(/DIR/, dir)
        File.open('public/index.html', 'w') do |file|
            file.puts index_file
        end
        s = WEBrick::HTTPServer.new(
                :Port => port,
                :DocumentRoot => 'public/index.html'
            )
        trap("INT"){ s.shutdown }
        s.start
	end	

end

s = Servdir.new
s.serve('/home/doug/', 2000)
