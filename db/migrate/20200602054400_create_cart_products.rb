class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|

    # ここから下を追加
      t.integer :member_id, null: false
      t.integer :product_id, null: false
      t.integer :quantity, null: false
    # ここから上を追加

      t.timestamps
    end
  end
end
