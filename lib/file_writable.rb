require 'fileutils'

module FileWritable
  def make_directory(file_name)
    FileUtils.mkpath(File.dirname(file_name))
  end
end