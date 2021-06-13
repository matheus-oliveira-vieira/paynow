class ChangeTypeToBeIntegerInPayments < ActiveRecord::Migration[6.1]
  def change
    change_column :payments, :type, :integer
  end
end
