class ChangeDatePaymentToBeDateInCharges < ActiveRecord::Migration[6.1]
  def change
    change_column :charges, :date_payment, :date
  end
end
