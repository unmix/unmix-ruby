module Unmix
  class YouTubeMetaToTracks

    attr_accessor :params, :youtube_description, :youtube_title, :tracks

    def initialize(params = {})
      @params = params
      @youtube_description = params[:description]
      @youtube_title = params[:title]
      @tracks = []
    end

    def track_name(text)
      name = text.gsub(/(\d*:\d*)|(\d*:\d*:\d*)/,'')      # remove mm:ss or hh:mm:ss
      name = name.gsub(/^\d*(\.|:|\)|\-)*/ ,'')           # remove track numbering
      name = name.gsub(/\-||/ ,'').lstrip!.rstrip!        # remove unwanted chars
    end

    def start_time(text)
      text.match(/\d*:((\d|\d\d)|:)*/).to_s
    end

    def set_tracks_basic_info
      album_title = guess_album_from_title
      lines = youtube_description.split("\n").select{ |line| line =~ /\d:\d/ }
      lines.each_with_index do |line, index|
        track = {
          original_text: line,
          index: (index+1).to_s.rjust(2,'0'),
          start_time: start_time(line),
          process_file: "#{Unmix.process_dir}/#{SecureRandom.urlsafe_base64(4)}.m4a",

          title: track_name(line),
          artist: guess_artist_from_title,
          album: guess_album_from_title,
          artist_album: guess_artist_from_title,
          genre: "unknown",
          year: guess_album_year_from_description,
          track_number: (index+1).to_s.rjust(2,'0').to_i,
          tracks_count: lines.count
        }
        tracks << track
      end
    end

    def guess_album_from_title
      # very very bad guess for now... but we will improve this :)
      album = youtube_title.split(" ") - ["FULL","Full","full","ALBUM","Album","album"]
      album.join(" ")
    end

    def guess_artist_from_title
      # very very bad guess for now... but we will improve this :)
      youtube_title[/(?:^|(?:[.!?]\s))(\w+)/,1]
    end

    def guess_album_year_from_description
      youtube_description[/19\d\d|20\d\d/]
    end

    def set_tracks_end_times
      tracks.each_with_index do |track, index|
        if track == tracks.last
          track[:end_time] = "5:00:00" #stupid, but works for now
        else
          track[:end_time] = tracks[index+1][:start_time]
        end
      end    
    end

    def set_tracks_durations
      tracks.each do |track|

        # I know it's VERY stupid but it's 5am and I'm over this stupid time crap and want to move on
        time_arr = track[:end_time].split(":")
        if time_arr.count == 2
          end_hh = 0
          end_mm = time_arr[0].to_i
          end_ss = time_arr[1].to_i
        else
          end_hh = time_arr[0].to_i
          end_mm = time_arr[1].to_i
          end_ss = time_arr[2].to_i
        end

        time_arr = track[:start_time].split(":")
        if time_arr.count == 2
          start_hh = 0
          start_mm = time_arr[0].to_i
          start_ss = time_arr[1].to_i
        else
          start_hh = time_arr[0].to_i
          start_mm = time_arr[1].to_i
          start_ss = time_arr[2].to_i
        end
        track[:duration] = Time.new(1970, 1, 1, end_hh, end_mm, end_ss) - Time.new(1970, 1, 1, start_hh, start_mm, start_ss)
      end
    end

    def perform
      set_tracks_basic_info
      set_tracks_end_times
      set_tracks_durations

      tracks
    end
  end
end