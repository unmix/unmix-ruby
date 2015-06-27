module Unmix
  class AtomicparsleyMetadataTags

    attr_accessor :track, :cover_filepath, :cover, :command

    def initialize(params = {})
      @track = params[:track]
      @cover = params[:cover_filepath]

      @command = "AtomicParsley "
      set_inputfile
      set_song_title
      set_artist_name
      set_album
      set_album_artist
      set_genre
      set_year
      set_track_number
      set_artwork unless cover.nil?
      set_overwrite
    end

    def track
      @track
    end

    def set_inputfile
      @command << "#{track[:process_file]} "
    end

    def set_song_title
      @command << "--title \"#{track[:title]}\" "
    end

    def set_artist_name
      @command << "--artist \"#{track[:artist]}\" "
    end

    def set_album
      @command << "--album \"#{track[:album]}\" "
    end

    def set_album_artist
      @command << "--albumArtist \"#{track[:artist_album]}\" "
    end

    def set_genre
      @command << "--genre \"#{track[:genre]}\" "
    end

    def set_year
      @command << "--year \"#{track[:year]}\" "
    end

    def set_track_number
      @command << "--tracknum \"#{track[:track_number]}/#{track[:tracks_count]}\" "
    end

    def set_artwork
      @command << "--artwork \"#{cover}\" "
    end

    def set_overwrite
      @command << "-W "
    end

    def perform
      `#{command} 2>&1`
    end

  end
end
