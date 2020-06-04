class TweetsController < ApplicationController    
    def index
        @tweets = Tweet.all.order(created_at: :desc).includes(user: :avatar_attachment)        
    end    
end
