class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.references :product, foreign_key: true
      t.references :payment_method, foreign_key: true
      t.decimal :discount_percentage

      t.timestamps
    end
  end
end
