class OrginizerAppBase

  # the main tracks array
  # track[:original_text]   = original text
  # track[:name]            = track's name
  # track[:index]           = track index number from original text
  # track[:filename]        = analyzed filename to create for this track
  # track[:start_time]      = start time of the track
  attr_accessor :tracks

  # original URL that was the source for all of this craziness
  attr_accessor :url

  # text that was analyze to generate the track list
  attr_accessor :description

  def sanitize_filename(filename)
    filename.gsub!(/[^0-9A-Za-z.\-]/, '_')
  end  

end