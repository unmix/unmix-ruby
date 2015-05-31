module Unmix
  class MixcloudTracksAnalyzer

    attr_accessor :params, :url, :api_url, :tracks, :command

    def initialize(params = {})
      @params = params
      @url = params[:url]
      @api_url = mixcloud_url_to_api_url url
      @tracks = []
    end

    def options
      {}
    end

    def set_tracks_basic_info(sections)
      sections.each_with_index do |section, index|
        track = {
          name: section["track"]["artist"]["name"] + " - " + section["track"]["name"],
          index: (index+1).to_s.rjust(2,'0'),
          start_time: section["start_time"],
          process_file: "#{Unmix.process_dir}/#{SecureRandom.urlsafe_base64(4)}.m4a"
        }
        @tracks << track
      end
    end

    def set_tracks_end_times(sections, total_length)
      tracks.each_with_index do |track, index|
        if track == tracks.last
          track[:end_time] = total_length
          track[:duration] = track[:end_time] - track[:start_time]
        else
          track[:end_time] = sections[index+1]["start_time"]
          track[:duration] = track[:end_time] - track[:start_time]
        end
      end
    end

    def perform
      data = JSON.parse(mixcloud_api_call(api_url))
      sections = data["sections"]

      set_tracks_basic_info sections
      set_tracks_end_times sections, data["audio_length"]

      tracks
    end

    def mixcloud_url_to_api_url(url)
      # temp solution...
      url.gsub("www","api")
    end

    def mixcloud_api_call(url)
      rc = RestClient::Resource.new url, options
      rc.get
    end
  end
end