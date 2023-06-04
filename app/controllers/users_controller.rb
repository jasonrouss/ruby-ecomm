class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:show, :edit, :update]
  
    def show
      @user = current_user
    end
  
    def edit
      @user = current_user
    end
  
    def update
      @user = current_user
      if @user.update(user_params)
        flash[:success] = 'Profile updated successfully.'
        redirect_to user_path(@user)
      else
        render :edit
      end
    end
    def profile
      @user = current_user
      @user_info = current_user.user_info || current_user.build_user_info
      @payment_info = current_user.payment_info || current_user.build_payment_info
     end

    private
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :last_name, :shipping_address, :billing_address)
    end
  end
  