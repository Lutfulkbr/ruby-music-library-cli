require "pry"
class Song
    extend Concerns::Findable

    attr_accessor :name
    attr_accessor :artist
    attr_accessor :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist=artist if artist
        self.genre=genre if genre
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        if !(genre.songs.include?(self))
            genre.songs << self
        end
    end

    def self.new_from_filename(filename)
        file_name = filename.split(" - ")
        artist_name, song_name, genre_name = file_name[0], file_name[1], file_name[2].gsub(".mp3", "")
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end

end