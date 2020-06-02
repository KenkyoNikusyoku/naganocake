class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|

    # ここから下を追加
      t.integer :product_id, null: false
      t.integer :order_id, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.integer :work_status, default: 1, null: false
    # ここから上を追加

      t.timestamps
    end
  end
end
