#!/usr/bin/env ruby
#
# Serves the files in a folder over HTTP
#

require 'rubygems'
require 'webrick'
require 'haml'

class Servdir
    def initialize
    end

    def make_html(dir)
        haml=<<EOF
!!! XHTML
%html{ :xmlns => "http://www.w3.org/1999/xhtml", "xml:lang" => "en"}
  %head
    %meta{ "http-equiv" => "content-type", :content => "text/xhtml" }
    %link{ :rel => "stylesheet", :type => "text/css", :href => "public/style.css"}
    %title Index of #{dir}
  %body
    #header
      %h2 Index of #{dir}
    #content
      - Dir.entries("#{dir}").each do |file|
        - path = "file://#{dir}/" + file
        %p
          %a(title=file){:href => path }= file
EOF

        engine = Haml::Engine.new(haml)
        index_file = engine.render
        File.open('public/index.html', 'w') do |file|
            file.puts index_file
        end
    end

	def serve
        s = WEBrick::HTTPServer.new(
                :Port => 2000,
                :DocumentRoot => 'public',
                :FancyIndexing => true
            )
        trap("INT"){ s.shutdown }
        s.start
	end	

end

#s = Servdir.new
#s.make_html("/home/doug/work")
#s.serve
