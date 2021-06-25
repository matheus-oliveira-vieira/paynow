class AddBankCodeErrorToCharge < ActiveRecord::Migration[6.1]
  def change
    add_column :charges, :bank_code_error, :string
  end
end
