require "pry"
require "ruby-youtube-dl"

class YouTubeFullAlbumApplication < OrginizerAppBase

  PROCESS_DIRECTORY = "./tmp"
  DOWNLAOD_FILE_PATH = "#{PROCESS_DIRECTORY}/_download.m4a"

  def url=(url)
    @url = url
  end

  def start_time(text)
    text.match(/\d*:((\d|\d\d)|:)*/).to_s
  end

  def filename(text)
    text.gsub(/([\d,:,.,\,'," ])/, '').downcase
  end

  def track_name(text)
    name = text.gsub(/(\d*:\d*)|(\d*:\d*:\d*)/,'')      # remove mm:ss or hh:mm:ss
    name = name.gsub(/^\d*(\.|:|\)|\-)*/ ,'')           # remove track numbering
    name.squeeze(" ")                                   # remove extra spaces
  end

  def cut_command(track)
    cmd = "ffmpeg -y "
    cmd << "-ss #{track[:start_time]} -i #{DOWNLAOD_FILE_PATH} -t #{track[:duration]} "
    cmd << "-vn -c:a copy "
    cmd << "#{PROCESS_DIRECTORY}/#{sanitize_filename(track[:index] + '.' + track[:name])}.m4a"
  end  

  def analyze_description(text)
    lines = text.split("\n").select{ |line| line =~ /\d:\d/ }
    lines.each_with_index do |line, index|
      track = {
        :original_text => line,
        :name => track_name(line),
        :index => (index+1).to_s.rjust(2,'0'),
        :filename => filename(line),
        :start_time => start_time(line)
      }
      tracks << track
    end
  end

  def analyze_end_time
    tracks.each_with_index do |track, index|
      if track == tracks.last
        track[:end_time] = "5:00:00" #stupid, but works for now
      else
        track[:end_time] = tracks[index+1][:start_time]
      end
    end    
  end

  def analyze_duration
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

  def description
    @description ||= `youtube-dl --get-description #{url}`
  end

  def prepare
    @tracks = Array.new

    analyze_description(description)
    analyze_end_time
    analyze_duration
  end

  def download
    system("rm -rf #{DOWNLAOD_FILE_PATH}")
    `youtube-dl -f bestaudio #{url} -o #{DOWNLAOD_FILE_PATH}`
  end

  def cut
    cut_commands = Array.new
    tracks.each do |track|
      command = cut_command(track)
      puts "Running #{command}"
      output = `#{command}`
    end

    puts cut_commands
  end

  def orginize
    
  end
end
