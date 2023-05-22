class UsersController < ApplicationController
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def index
    @users = User.all.order({ :username => :asc })

    render({ :template => "users/index.html" })
  end

  def show
    the_username = params[:the_username]
    @user = User.find_by(username: the_username)
  
    if @user.nil?
      redirect_to users_path
    end
  end

  def follow
    @user = User.find(params[:id])
  
    unless current_user.following?(@user)
      if @user.private?
        # Create a follow request
        follow_request = FollowRequest.new(sender: current_user, recipient: @user)
        follow_request.save if follow_request.persisted?
      else
        # Perform the follow logic
        current_user.following << @user
      end
    end
  
    redirect_to user_path(@user)
  end
  
  def unfollow
    @user = User.find(params[:id])
    current_user.following.delete(@user) if current_user.following?(@user)
    redirect_to user_path(@user.username)
  end
  
  def cancel_request
    @user = User.find(params[:user_id])
    follow_request = FollowRequest.find_by(sender: current_user, recipient: @user)
    
    if follow_request
      if authorized_to_cancel?(current_user, follow_request)
        follow_request.destroy
        flash[:notice] = "Follow request cancelled"
      else
        flash[:alert] = "You're not authorized for that."
      end
    else
      flash[:alert] = "No follow request found"
    end
    
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def authorized_to_cancel?(user, follow_request)
    # replace with your authorization logic
    user == follow_request.sender
  end

  def feed
    @user = User.find(params[:user_id])
    @photos = @user.following.flat_map { |user| user.own_photos }.sort_by(&:created_at).reverse
  end
  
  def discovery
    @user = User.find(params[:user_id])
    @photos = @user.following.flat_map { |user| user.likes.map(&:photo) }.sort_by(&:created_at).reverse
  end

  def liked_photos
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path, alert: "User not found"
      return
    end
    @photos = @user.liked_photos
  end
  
  def edit
    @user = User.find(params[:id])
    if @user.errors.any?
      render 'edit_profile_with_errors'
    else
      render 'edit_profile'
    end
  end
end
