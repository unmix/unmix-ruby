module Unmix
  class FolderOrginizer

    attr_accessor :folder, :tracks

    def initialize(params = {})
      @tracks = params[:tracks]
      @folder = params[:folder]
    end

    def move
      FileUtils.mkdir_p folder
      tracks.each do |track|
        filename = Unmix::filename_for_track(track[:index], track[:name])
        FileUtils.mv(track[:process_file], "#{folder}/#{filename}")
      end      
    end

    def clean_up
      tracks.each do |track|
        FileUtils.rm_rf(track[:process_file])
      end      
    end

    def perform
      move
      clean_up
    end
  end
end