require 'rails_helper'
require 'spec_helper'
require 'support/action_controller_workaround.rb'
# require 'support/factory_girl.rb'
require 'simplecov'
SimpleCov.start 'rails'

RSpec.describe Movie, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  before (:each) do
        @movie1 = FactoryGirl.create(:movie, id: '1', title: 'Star Wars', director: 'George Lucas')
        @movie2 = FactoryGirl.create(:movie, id: '2', title: 'THX-1138', director: 'George Lucas')
        @movie3 = FactoryGirl.create(:movie, id: '3', title: 'Blade Runner', director: 'Ridley Scott')
        @movie4 = FactoryGirl.create(:movie, id: '4', title: 'Red Tails', director: 'George Lucas')
        @movie5 = FactoryGirl.create(:movie, id: '5', title: 'Frozen', director: '')
    end
  
  describe 'Find movies whose director matches' do
        
        it "should return movies list whose derictor matches the specific movie (NOT included) if there exist" do 
   
            result = Movie.find_director_matches(@movie1)
            expect(result.first).to eq(@movie2)
            expect(result.second).to eq(@movie4)
        end
        
        it "should not return matches of movies by different directors" do 
            
            result = Movie.find_director_matches(@movie1)
            result.each do |m|
                expect(m).to_not eq(@movie3)
            end
        end
        
        it "should return a empty array if there is no match" do 
          
            result = Movie.find_director_matches(@movie3)
            expect(result).to be_empty
        end
     
  end
  
  describe 'check_director' do
        it "should return false if the movie has no director info" do 
          
            result = Movie.check_director(@movie5)
            result2 = Movie.check_director(@movie1)
            # check if "check_empty" can correctly check if the movie has director, or not. 
            expect(result).to be false
            expect(result2).to be true
        end
  end
  
end
