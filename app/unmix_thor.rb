module Unmix
  class UnmixThor < Thor

    default_task :auto
    method_option :input, :aliases => "-i", :desc => "Input URL", :required => true

    desc "Auto", "Automaticlly analyze and Unmix a given URL"
    long_desc <<-LONGDESC
      This command will:
        1. Download best avaiable quality of a youtube URL (a music album)
        2. Try to figure out where are the cutting points
        3. Cut the original file into multiple files
        4. Rename the files to songs names
    LONGDESC

    def auto
      # set up
      app = Unmix::YouTubeFullAlbum.new

      say "Step 1: Analyzing source #{options[:input]}", :green
      app.step_1 options[:input]
      
      say "Found the following information:", :green
      tp app.tracks, :index, :name, :duration, :start_time, :end_time
      say ""

      if no?("auto detection enabled. Is this correct or you would like to manually edit it?", :green) 
        # manual input
        exit!
      end

      say "Donwloading.", :green
      app.step_2

      # cut the video file into pieces
      say "Cutting Video File.", :green
      app.step_3

      # orginize the cuted files into an album folder
      say "Orginizing Into an Album Folder.", :green
      app.step_4

      say "All Done!", :green
    end

    desc "doctor", "Script doctor, validate that the script's dependencies exists"
    def doctor
      EXTERNALS_COMMANDS.each do |cmd|
        Unmix::cmd_exist?(cmd.to_s)? puts("#{cmd} was found".green) : puts("#{cmd} was not found".red)
      end
    end
  end  
end