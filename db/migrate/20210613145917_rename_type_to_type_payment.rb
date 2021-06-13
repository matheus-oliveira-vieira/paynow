class RenameTypeToTypePayment < ActiveRecord::Migration[6.1]
  def change
    rename_column :payments, :type, :type_payment
  end
end
