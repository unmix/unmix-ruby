module Unmix
  class SourceBase

    # the main tracks array
    # track[:original_text]   = original text
    # track[:name]            = track's name
    # track[:index]           = track index number from original text
    # track[:filename]        = analyzed filename to create for this track
    # track[:start_time]      = start time of the track
    # track[:process_file]    = temporary, post cut file
    attr_accessor :tracks

    # original URL that was the source for all of this craziness
    attr_accessor :url

    # text that was analyze to generate the track list
    attr_accessor :description

    def step_1(url)
      raise "Unimplemented Source base method"
    end

    def step_2
      raise "Unimplemented Source base method"
    end

    def step_3
      raise "Unimplemented Source base method"
    end

    def step_4
      raise "Unimplemented Source base method"
    end


  end
end