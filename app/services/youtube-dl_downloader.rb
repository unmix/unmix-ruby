module Unmix
  class YouTubeDLDownloader

    attr_accessor :params, :url, :platform, :command

    def initialize(params = {})
      @url = params[:url]
      @platform = params[:platform]

      @command = "youtube-dl "

      add_no_check_certificate
      add_best_audio
      add_url
      set_output(Unmix::temp_download_file_path)
    end

    def add_no_check_certificate
      @command << "--no-check-certificate "
    end

    def add_best_audio
      @command << "-f bestaudio " if platform == :youtube
      @command << "-f 0 " if platform == :mixcloud
    end

    def add_url
      @command << "#{url} "
    end

    def set_output(output)
      @command << "-o #{output}"
    end

    def perform
      system(command)
    end
  end
end