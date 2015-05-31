module Unmix
  class FFmpegFileCutter

    attr_accessor :command

    def initialize(params = {})
      input = params[:input]
      start_time = params[:start_time]
      duration = params[:duration]
      output = params[:output]

      @command = "ffmpeg "
      add_overwrite
      add_start_time start_time
      set_input input
      add_duration duration
      set_no_video
      set_audio_encoding "copy"
      set_output_file output
    end

    def add_overwrite
      @command << "-y "
    end

    def add_start_time(time)
      @command << "-ss #{time} "
    end

    def set_input(input)
      @command << "-i #{input} "
    end

    def add_duration(duration)
      @command << "-t #{duration} "
    end

    def set_no_video
      @command << "-vn "
    end

    def set_audio_encoding(encoding)
      @command << "-c:a #{encoding} "
    end

    def set_output_file(output)
      @command << output
    end

    def perform
      `#{command} 2>&1 `
    end
  end
end