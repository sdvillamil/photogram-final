class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })
    
    render({ :template => "users/index" })
  end

  def show
    user_name = params.fetch("path_id")

    @the_user = User.where({ :username => user_name}).at(0)

    if @the_user.nil?
      redirect_to("/users", alert: "User not found.") and return
    end

    user_photos = @the_user.own_photos

    @list_of_photos = user_photos.order({ :created_at => :desc})

    render({ :template => "users/show" })
  end

  def edit_profile
    render({ :template => "users/edit_profile" })
  end
end
