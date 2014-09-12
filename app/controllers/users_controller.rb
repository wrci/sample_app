class UsersController < ApplicationController
  def new
  	@titre = "Inscription"
  end
  
  def show
  	@user = User.find(params[:id])
  end
  
  def user_params
      params.require(:user).permit(:nom, :email)
  end
   
end
