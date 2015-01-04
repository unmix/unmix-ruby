class OrginizerAppBase

  # the main tracks array
  # track[:original_text]   = original text
  # track[:index]           = track index number from original text
  # track[:filename]        = analyzed filename to create for this track
  # track[:start_time]      = start time of the track
  attr_accessor :tracks

  # original URL that was the source for all of this craziness
  attr_accessor :url

  # text that was analyze to generate the track list
  attr_accessor :description

  def manual_input
    @tracks = []
  end

  def print_tracks
    text = ""
    tracks.each do |track|
      text += "\t#{track[:index]}. #{track[:filename]} - #{track[:start_time]}\n"
    end
    text
  end

end