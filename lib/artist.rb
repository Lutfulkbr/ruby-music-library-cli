require "pry"
class Artist
    extend Concerns::Findable
    
    attr_accessor :name
    attr_accessor :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end

    def self.destroy_all
        @@all.clear
    end

    def songs
        @songs
    end

    def add_song(song)
        # binding.pry
        songs << song unless songs.include?(song)
        song.artist = self unless song.artist
    end

    def genres
        songs.collect {|song| song.genre}.uniq
    end
    
end