class UserInfosController < ApplicationController
  def edit
    @user_info = current_user.user_info || current_user.build_user_info
    super
  end

  def update
    @user_info = current_user.user_info || current_user.build_user_info
    if @user_info.update(user_info_params)
      redirect_to user_profile_path, notice: "User information updated successfully."
    else
      render :edit
    end
  end

  private

  def user_info_params
    params.require(:user_info).permit(:street, :city, :state, :zip, :country )
  end
end
