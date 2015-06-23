###############################################################################
# 
# THIS MODEL IS STILL "WORK IN PROGRESS" WHICH MAY BE NEVER COMPLETED SINCE
# FFMPEG DOES NOT PROPERLY SUPPORT WRITING MJPEG INTO MP4/M4A CONTAINERS
# 
# EG
#
###############################################################################

module Unmix
  class FFmpegId3v2FileTagger
    attr_accessor :track
    attr_accessor :title
    attr_accessor :artwork_url
    attr_accessor :command

    def initialize(params = {})
      @track = params[:track]
      @did_set_artwork = false

      @command = "ffmpeg "
      add_overwrite
      set_inputfile
      set_artwork unless @track[:artwork].nil?
      set_id3version
      set_title
      set_artist_name
      set_album
      set_album_artist
      set_genre
      set_year
      set_track_number
      set_copy_audio_streams
      binding.pry
      set_outputfile
    end

    def add_overwrite
      @command << "-y "
    end

    def set_inputfile
      @command << "-i << INPUT >> "
    end

    def set_artwork
      # WIP COMMAND: ffmpeg -loglevel debug -y -i "input.m4a" -i "art.jpg" -c:v copy -id3v2_version 4 -metadata title="unmix-title" -metadata artist="unmix-artist" -metadata album="unmix-album" -metadata album_artist="unmix-album_artist" -metadata genre="unmix-genre" -metadata date="2015" -metadata track="1/12" -c:a copy -map 0:0 -map 1:0 "output.m4a"
      @did_set_artwork = true
      @command << "-i #{track[:artwork]} -map 0:0 -map 1:0 "
    end

    def set_id3version
      @command << "-id3v2_version 4 "
    end

    def set_title
      @command << "-metadata title=\"#{track[:title]}\" "
    end

    def set_artist_name
      @command << "-metadata artist=\"#{track[:artist]}\" "
    end

    def set_album
      @command << "-metadata album=\"#{track[:album]}\" "
    end

    def set_album_artist
      @command << "-metadata album_artist=\"#{track[:artist_album]}\" "
    end

    def set_genre
      @command << "-metadata genre=\"#{track[:genre]}\" "
    end

    def set_year
      @command << "-metadata date=\"#{track[:year]}\" "
    end

    def set_track_number
      @command << "-metadata track=\"#{track[:track_number]}/#{track[:tracks_count]}\" "
    end

    def set_copy_audio_streams
      @command << "-c:a copy "
    end

    def set_outputfile
      @command << "#{track[:process_file]}"
    end

    def perform
    end

  end
end
