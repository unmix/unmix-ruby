#!/usr/bin/env ruby
require "thor"
require "pry"
require "ruby-youtube-dl"

class YoutubeFullAlbum < Thor
  desc "download", "Download Procedure"
  long_desc <<-LONGDESC
    This command will:
      1. Download best avaiable quality of a youtube URL (a music album)
      2. Try to figure out where are the cutting points
      3. Cut the original file into multiple files
      4. Rename the files to songs names
  LONGDESC

  method_option :input, :aliases => "-i", :desc => "Input URL", :required => true

  def download
    puts "Trying to download #{options[:input]}"
  end
end

YoutubeFullAlbum.start