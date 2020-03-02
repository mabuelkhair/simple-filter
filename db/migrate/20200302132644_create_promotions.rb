class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions do |t|
      t.decimal :discount, precision: 5, scale: 2
      t.boolean :active

      t.timestamps
    end
  end
end
