class UsersController < ApplicationController
  def index
    matching_users = User.all
    @list_of_users = matching_users.order({ :created_at => :desc })
    render({ :template => "users/index.html.erb" })
  end

  def show
    user_name = params.fetch("path_id")
    #Users_unique

    @the_user = User.where({ :username => user_name}).at(0)

    
    render({ :template => "users/show.html.erb" })
  end
end
