require "fileutils"

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
      File.open(object_path, "w", &block)
    end

    private

    attr_reader :sha
  end
end
