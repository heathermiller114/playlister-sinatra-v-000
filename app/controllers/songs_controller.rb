require 'rack-flash'

class SongsController < ApplicationController
    use Rack::Flash

    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'songs/new'
    end

    post '/songs' do
        #binding.pry
        @song = Song.create(name: params[:song_name])
        @song.artist = Artist.find_or_create_by(name: params[:artist_name])
        @song.genre_ids = params[:genres]
        @song.save

        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"

    end
    
    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
       # binding.pry
        erb :'songs/show'
    end

    get '/songs/:slug/edit' do

    end

    patch '/songs/:slug' do
        
    end

end

