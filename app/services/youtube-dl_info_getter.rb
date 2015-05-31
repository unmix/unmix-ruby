module Unmix
  class YouTubeDLInfoGetter

    attr_accessor :params, :url, :command

    def initialize(params = {})
      @params = params
      @url = params[:url]

      # build command to execute
      @command = "youtube-dl "
      
      add_no_check_certificate
      add_title       if params[:title]
      add_description if params[:description]
      add_url
    end

    def perform
      analyze_response(`#{command}`)
    end

    def add_title
      @command << "--get-title "
    end

    def add_no_check_certificate
      @command << "--no-check-certificate "
    end

    def add_url
      @command << @url
    end

    def add_description
      @command << "--get-description "
    end

    def analyze_response(text)
      data = {}
      text = text.split("\n")
      if params[:title]
        data[:title] = text.shift
        data[:description] = text.join("\n") if params[:description]
      else
        data[:description] = text.join("\n")
      end
      data
    end
  end
end