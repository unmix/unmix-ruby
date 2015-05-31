module Unmix
  def self.cmd_exist?(command)
    begin
      Open3.popen3(command) do |stdin, stdout, stderr, thread|
      end
    rescue Errno::ENOENT
      return false
    end  
    return true
  end

  def self.sanitize_filename(filename)
    filename.gsub!(/[^0-9A-Za-z.\-]/, '_')
  end

  def self.filename_for_track(index, name)
    "#{sanitize_filename(index + '.' + name)}.m4a".gsub(/_/,'')
  end

  def self.export_dir(title)
    "./exports/#{sanitize_filename(title)}"
  end

  def self.process_dir
    "./tmp"
  end

  def self.temp_download_file_path
    "#{process_dir}/_download.m4a"
  end

end