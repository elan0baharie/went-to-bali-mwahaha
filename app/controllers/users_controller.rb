class UsersController < ApplicationController

  def new
  end

  def show
    @user = current_user

  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:user_success] = "You have signed up successfully"
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def update
    @user = current_user
    puts "Update"
    if @user.update(user_params)
      puts "Printing"
      if @user.priviledge == "Loren"
        @user.admin = true
        @user.save
        flash[:admin_success] = "Admin is granted."
        redirect_to user_path(@user)
      elsif @user.priviledge == ""
        flash[:admin_nonentry] = "If you do not know it is wisest to remain silent."
        redirect_to user_path(@user)
      else
        puts "Broken"
        flash[:admin_fail] = "Wrong! Loren is the wisest!"
        redirect_to user_path(@user)
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :priviledge)
  end

end
