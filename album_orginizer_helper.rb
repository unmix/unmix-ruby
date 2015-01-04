require 'open3'
require "./apps/orginizer_app_base.rb"
require "./apps/youtube_full_album.rb"

def cmd_exist?(command)
  begin
    Open3.popen3(command) do |stdin, stdout, stderr, thread|
    end
  rescue Errno::ENOENT
    return false
  end  
  return true
end
