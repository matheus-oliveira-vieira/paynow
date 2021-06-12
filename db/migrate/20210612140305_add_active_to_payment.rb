class AddActiveToPayment < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :active, :boolean
  end
end
