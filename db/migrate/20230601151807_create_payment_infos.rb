class CreatePaymentInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_infos do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :credit_card_number
      t.string :expiration_date
      t.string :security_code
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
