class AddWinningPositionToCashOuts < ActiveRecord::Migration[7.1]
  def change
    add_column :cash_outs, :position, :integer
  end
end
