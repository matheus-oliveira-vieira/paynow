class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.references :company, foreign_key: true
      t.references :product, foreign_key: true
      t.references :payment_method, foreign_key: true
      t.references :client, foreign_key: true
      t.references :discount, foreign_key: true
      t.string :card_number
      t.string :card_name
      t.string :card_code
      t.string :boleto_address
      t.decimal :original_price
      t.decimal :new_price
      t.string :token
      t.integer :status

      t.timestamps
    end
  end
end
