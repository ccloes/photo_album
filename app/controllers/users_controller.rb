class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def init
    album_url = "https://jsonplaceholder.typicode.com/albums"
    photos_url = "https://jsonplaceholder.typicode.com/photos"

    album_response = HTTParty.get(album_url)
    album_body = JSON.parse(album_response.body)
    photos_response = HTTParty.get(photos_url)
    photos_body = JSON.parse(photos_response.body)

#    @users = User.all
#    @albums = Album.all
#    @photos = Photo.all

    album_body.each do |album|
      if User.exists?(album['userId'])
        puts '.'
      else
        puts 'User not found... creating user'
        u = User.new
        u.id = album['userId']
        u.name = album['userId']
        u.save
      end
    end

    album_body.each do |album|
      if Album.exists?(album['id'])
        puts '.'
      else
        a = Album.new
        a.id = album['id']
        a.user_id = album['userId']
        a.title = album['title']
        a.save
        puts 'Album created... '
      end
    end

    photos_body.each do |photo|
      if Album.exists?(photo['albumId'])
        puts 'Re-checked'
      else
        puts 'Album not found... this should raise an error'
      end
    end

    photos_body.each do |photo|
      if Photo.exists?(photo['id'])
        puts 'Photo already exists... '
      else
        puts 'Photo not found... creating photo'
        p = Photo.new
        p.album_id = photo['albumId']
        p.id = photo['id']
        p.title = photo['title']
        p.url = photo['url']
        p.thumbnailUrl = photo['thumbnailUrl']
        p.save
      end
    end

    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'App was successfully initialized.' }
      format.json { head :no_content }
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end
end
