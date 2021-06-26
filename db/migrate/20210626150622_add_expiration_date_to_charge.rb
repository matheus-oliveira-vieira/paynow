class AddExpirationDateToCharge < ActiveRecord::Migration[6.1]
  def change
    add_column :charges, :expiration_date, :date
  end
end
