class AddDatePaymentToCharge < ActiveRecord::Migration[6.1]
  def change
    add_column :charges, :date_payment, :string
  end
end
