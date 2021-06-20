class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.references :payment, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :code
      t.string :agency
      t.string :bank_account

      t.timestamps
    end
  end
end
