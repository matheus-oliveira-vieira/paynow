class AddPaymentConfirmationToCharge < ActiveRecord::Migration[6.1]
  def change
    add_column :charges, :payment_confirmation, :string
  end
end
