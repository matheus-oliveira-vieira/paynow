class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :name
      t.string :type
      t.decimal :fee_percentage
      t.decimal :max_fee

      t.timestamps
    end
  end
end
