class AddBankCodeToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :bank_code, :string
  end
end
