#!/usr/bin/env ruby
require "thor"
require "pry"
require "table_print"
require "./album_downloader_helper.rb"

class AlbumDownloader < Thor

  desc "Youtube", "YouTube Download Procedure"
  long_desc <<-LONGDESC
    This command will:
      1. Download best avaiable quality of a youtube URL (a music album)
      2. Try to figure out where are the cutting points
      3. Cut the original file into multiple files
      4. Rename the files to songs names
  LONGDESC

  method_option :input, :aliases => "-i", :desc => "Input URL", :required => true

  def youtube
    # set up
    app = YouTubeFullAlbumApplication.new
    app.url = options[:input]

    # execute
    say "Getting Video's description...", :green
    app.prepare
    
    say "Found the following track list:", :green
    tp app.tracks, :index, :name, :duration, :start_time, :end_time

    if no?("Is it correct?", :green) 
      # manual input
      tracks = []
      say "TODO", :red
      exit!
    end

    say "Donwloading: #{app.url}", :green
    app.download

    app.cut
    return;

    app.orginize
  end

  desc "doctor", "Script doctor, validate that the script's dependencies exists"
  def doctor
    cmd_exist?("youtube-dl") ? say("youtube-dl", :green) : say("youtube-dl was not found", :red)
  end

  default_task :youtube
end


AlbumDownloader.start