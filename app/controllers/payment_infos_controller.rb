class PaymentInfosController < ApplicationController
  def edit
    @payment_info = current_user.payment_info || current_payment.build_user_info
    super
  end

  def update
    @payment_info = current_user.payment_info || current_user.build_payment_info
    if @payment_info.update(payment_info_params)
      redirect_to user_profile_path, notice: "Payment information updated successfully."
    else
      render :edit
    end
  end

  private

  def payment_info_params
    params.require(:payment_info).permit(:street, :city, :state, :zip, :country, :credit_card_number,:expiration_date, :security_code , :first_name, :last_name  )
  end
end
