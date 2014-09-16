class UsersController < ApplicationController
  def new
  	@titre = "Inscription"
  end
  
  def show
  	@user = User.find(params[:id])
  	@titre = @user.nom
  end
  
  def user_params
      params.require(:user).permit(:nom, :email, :password, :password_confirmation)
  end
   
end
