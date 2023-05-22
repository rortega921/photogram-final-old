class PhotosController < ApplicationController
  def index
    @photos = Photo.all.order(created_at: :desc)
  end

  def show
    @photo = Photo.includes(comments: :commenter).find(params[:path_id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.owner_id = session[:user_id] if session[:user_id] 
    @photo.image = params[:image]
    if @photo.save
      redirect_to photos_path, notice: 'Photo created successfully.'
    else
      render :new, alert: @photo.errors.full_messages.to_sentence
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to photo_path(@photo), notice: 'Photo updated successfully.'
    else
      render :edit, alert: @photo.errors.full_messages.to_sentence
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path, notice: 'Photo deleted successfully.'
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image, :owner_id)
  end
end
