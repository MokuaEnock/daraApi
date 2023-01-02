class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :phone
      t.integer :total

      t.timestamps
    end
  end
end
