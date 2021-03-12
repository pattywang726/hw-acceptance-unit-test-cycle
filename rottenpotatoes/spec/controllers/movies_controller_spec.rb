require 'rails_helper'
require 'spec_helper'
require 'support/action_controller_workaround.rb'
require 'simplecov'
SimpleCov.start 'rails'

RSpec.describe MoviesController, type: :controller do
    before (:each) do
    
        @m_test0= double('movie0', :id => 2, :title=>'THX-1138')
        @m_test= double('movie1', :id => 3, :title=>'Star Wars', :director=>'George Lucas')
        @m_result = double('movie2', :id => 4, :title=>'Red Tails', :director=>'George Lucas')
    end
    
    describe 'Find with same director' do
        it "should grab the id of the movie that is the subject of the match" do 
            
            Movie.should_receive(:find).with("3").and_return(@m_test)
            Movie.stub(:find_director_matches).and_return(@m_result)
            Movie.stub(:check_director).and_return(true)
            get :fdirector, {:id => 3}
        end
        
        it "should return Similar Movie page while specified movie has a director" do 
            
            Movie.stub(:find).and_return(@m_test)
            Movie.stub(:find_director_matches).and_return(@m_result)
            Movie.stub(:check_director).and_return(true)
            get :fdirector, {:id => 3}
            expect(response).to render_template('fdirector')
        end
        
        it "should return Home page while specified movie has no director info" do 
        
            Movie.stub(:find).and_return(@m_test0)
            Movie.stub(:check_director).and_return(false)
            get :fdirector, {:id => 2}
            expect(response).to redirect_to(movies_path)
            
        end
        
        it 'should make the error message available to that template' do
            Movie.stub(:find).and_return(@m_test0)
            Movie.stub(:check_director).and_return(false)
            get :fdirector, {:id => 2}
            flash[:notice].should eq("'#{@m_test0.title}' has no director info")
        end

    end
end
