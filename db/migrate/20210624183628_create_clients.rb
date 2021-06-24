class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :cpf
      t.string :token
      
      t.timestamps
    end
  end
end
