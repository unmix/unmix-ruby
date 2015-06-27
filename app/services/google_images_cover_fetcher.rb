require "google-search"

module Unmix
  class GoogleImagesCoverFetcher

    attr_accessor :selected, :query, :file, :min_size, :max_size

    ALBUM_COVER_MIN_SIZE = 500
    ALBUM_COVER_MAX_SIZE = 1000

    def initialize(params={})
      @query         = params[:query]
      @min_size      = ALBUM_COVER_MIN_SIZE
      @max_size      = ALBUM_COVER_MAX_SIZE
      @file = Tempfile.new "album-cover-"
    end

    def perform
      # fetch from google images
      gsi = ::Google::Search::Image.new(query: query)
      images = gsi.select { |i| i }

      # sort and fine the most relevant cover image
      @selected = images.first
      squres = images.select { |i| i.width == i.height }
      squres.sort! { |a,b| b.height <=> a.height }
      
      # prefered a big & squre cover photo
      @selected = squres.first unless squres.empty?

      # sort cover photo sizes by size, from biggest to smallest
      on_sizes = squres.select { |i| i.height > min_size && i.height < max_size }

      # prefered a cover photo in requested size
      @selected = on_sizes.last unless on_sizes.empty?

      # images.each_with_index { |img, i| ppprint img ; @selected = img if prefered?(iimg, i) }

      puts "will download selected cover: #{selected.width},#{selected.height},#{selected.uri}"
      download! file.path, selected.uri

      file.path
    end

    private
    def ppprint(item)
      tp item
    end

    def prefered?(img, index)
      begin
        binding.pry
        img.height == img.width && 
        (
          (index < 5) || 
          (selected.height < min_size) && (img.height < max_size )
        )
      rescue Exception => e
        binding.pry        
      end
    end

    # shamelessly copied from
    # http://stackoverflow.com/questions/2263540/how-do-i-download-a-binary-file-over-http
    def download!(filename,url)
      File.open(filename,'w'){ |f|
        uri = URI.parse(url)
        Net::HTTP.start(uri.host,uri.port){ |http| 
          http.request_get(uri.path){ |res| 
            res.read_body{ |seg|
              f << seg
              sleep 0.005
            }
          }
        }
      }
    end

  end
end