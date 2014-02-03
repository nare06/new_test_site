class UsersController < ApplicationController
before_filter :authenticate_user!
def index
 @title = "All Users"
 @users = User.all
end
def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title= @user.name 
  end  
def new
@user = User.new
  end
def create
@user = User.new(user_params)
if @user.save
  sign_in @user
  flash[:success] = "welcome to the sample App!"
  redirect_to @user
else
@title = "Sign up"
render 'new'
end
end
def edit
@user = User.find(params[:id])
@title = "Edit User"
end
def update
  @user = User.find(params[:id])
  if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
  else 
  render 'edit'
  end
end

private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
