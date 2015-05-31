module Unmix
  class UnmixThor < Thor

    default_task :auto

    desc "Auto", "Automaticlly analyze and Unmix a given URL"
    long_desc <<-LONGDESC
      Analyze input url and run unmix
    LONGDESC
    option :input, :aliases => "-i", :desc => "Input URL", :required => true

    def auto
      # set up
      app = Unmix::YouTubeAlbum.new url: options[:input], platform: "youtube"
      app.run
    end

    desc "Youtube", "Analyze and donwload a YouTube Album"
    long_desc <<-LONGDESC
      Will analyze, download, cut and orginize a m4a album based on the downloaded YouTube Video
    LONGDESC
    option :input, :aliases => "-i", :desc => "Input URL", :required => true

    def youtube
      app = Unmix::YouTubeAlbum.new url: options[:input], platform: "youtube"
      app.run
    end

    desc "Mixcloud", "Analyze and donwload a Mixcloud set and split into tracks"
    long_desc <<-LONGDESC
      Will analyze, download, cut and orginize a set folder based on the downloaded mixcloud set
    LONGDESC

    option :input, :aliases => "-i", :desc => "Input URL", :required => true

    def mixcloud
      app = Unmix::Mixcloud.new url: options[:input], platform: "mixcloud"
      app.run
    end

    desc "doctor", "Script doctor, validate that the script's dependencies exists"
    def doctor
      EXTERNALS_COMMANDS.each do |cmd|
        Unmix::cmd_exist?(cmd.to_s)? puts("#{cmd} was found".green) : puts("#{cmd} was not found".red)
      end
    end

  end  
end