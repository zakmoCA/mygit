require "fileutils"
require "zlib"
require "digest"

module MyGit
  MYGIT_DIR = "#{Dir.pwd}/.mygit".freeze
  OBJECTS_DIR = "#{MYGIT_DIR}/objects".freeze

  class Object
    def initialize(sha)
      @sha = sha
    end

    def write_contents(&block)
      object_dir = "#{OBJECTS_DIR}/#{sha[0..1]}"
      FileUtils.mkdir_p object_dir
      object_path = "#{object_dir}/#{sha[2..-1]}"

      # temp
      content = ""
      temp_io = StringIO.new(content)
      block.call(temp_io)

      # compress/fs write
      blob = Zlib::Deflate.deflate(content)
      File.open(object_path, "wb") do |file|
        file.write blob
      end
    end

    def read_contents
      object_path = "#{OBJECTS_DIR}/#{sha[0..1]}/#{sha[2..-1]}"
      begin
        Zlib::Inflate.inflate(File.read(object_path))
      rescue Zlib::Error
        raise "Failed to decompress object #{sha}"
      rescue Errno::ENOENT
        raise "Object not found: #{sha}"
      end
    end

    # read by SHA is better
    def self.read(sha)
      new(sha).read_contents
    end

    private

    attr_reader :sha
  end
end
