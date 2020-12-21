require "pry"
class MusicImporter
    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        Dir["#{@path}/*"].collect {|song| song.gsub("#{@path}/", "")}
    end

    def import
        files.each{|s| Song.create_from_filename(s)}
    end

end