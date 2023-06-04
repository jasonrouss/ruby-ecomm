class AddUserToPaymentInfos < ActiveRecord::Migration[7.0]
  def change
    add_reference :payment_infos, :user, null: false, foreign_key: true
  end
end
