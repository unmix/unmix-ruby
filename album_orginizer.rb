#!/usr/bin/env ruby
require "thor"
require "pry"
require "./album_orginizer_helper.rb"

class AlbumOrginizer < Thor

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
    say app.print_tracks + "\n"

    # if no?("Is it correct?", :green) 
    #   # manuall input
    #   tracks = []
    #   say "TODO", :red
    #   exit!
    # end

    say "Donwloading: #{app.url}"
    app.download

    app.cut
    binding.pry
    return;

    app.orginize
  end

  desc "doctor", "Script doctor, validate that the script's dependencies exists"
  def doctor
    cmd_exist?("youtube-dl") ? say("youtube-dl", :green) : say("youtube-dl was not found", :red)
  end

  default_task :youtube
end


AlbumOrginizer.start