class CreateCashOuts < ActiveRecord::Migration[7.1]
  def change
    create_table :cash_outs do |t|
      t.string :name
      t.integer :cash
      t.integer :shifts
      t.integer :tickets

      t.timestamps
    end
  end
end
