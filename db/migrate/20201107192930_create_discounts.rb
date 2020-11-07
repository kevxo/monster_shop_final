class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.decimal :percent, :precision => 3, :scale => 2
      t.references :merchant, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
