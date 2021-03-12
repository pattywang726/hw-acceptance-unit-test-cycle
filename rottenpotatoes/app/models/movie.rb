class Movie < ActiveRecord::Base
    def self.all_ratings
    %w(G PG PG-13 NC-17 R)
    end
    
    def self.find_director_matches(movie)
        #  movie.director should not be empty
        specificD = movie.director
        similarM = Movie.where(:director => specificD)
        # remove the specified movie from the return slimilar list
        similarM = similarM.to_a
        similarM.delete_at(similarM.find_index(movie))
        return similarM 
    end
    
    def self.check_director(movie)
        # check if the movie has the field, director or not
        specificD = movie.director
        if specificD == nil
            return false
        elsif specificD == ""
            return false
        else
            return true
        end
    end
end
