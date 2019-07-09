class Api::V1::PlaylistsController < ApplicationController

    def index 
        render json: (Api::V1::Playlist.all.where(user_id: params[:user]))
    end

    def create 
        @image = Cloudinary::Uploader.upload(playlist_params[:playlist_image])
        @playlist = Api::V1::Playlist.create(id: playlist_params[:id], name: playlist_params[:name], user_id: playlist_params[:user_id], description: playlist_params[:description])
        
        @playlist.update(playlist_image: @image["url"])
        
        if @playlist.save
            render json: @playlist, status: :created
        else 
            render json: { error: 'failed to create playlist' }, status: :not_acceptable
        end
    end 

    def show 
        render json: Api::V1::Playlist.find(params[:id])
    end 

    def update 
        @playlist = Api::V1::Playlist.find(params[:id])
        @image = Cloudinary::Uploader.upload(playlist_params[:playlist_image])
        @playlist.update(playlist_params)
        @playlist.update(playlist_image: @image["url"])
        render json: Api::V1::PlaylistSerializer.new(@playlist)
    end 
    
    def destroy
        render json: Api::V1::Playlist.find(params[:id]).destroy
    end

    private 

    def playlist_params
        params.require(:playlist).permit(:id, :user_id, :name, :description, :playlist_image)
    end 

end
