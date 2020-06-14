class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

    # ここから下を追加
      t.integer :member_id, null: false
      t.string :receiver, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.integer :payment_option, null: false
      t.integer :status, default: 1, null: false
      t.integer :postage, default: 800, null: false
      t.integer :billing, null: false
    # ここから上を追加

      t.timestamps
    end
  end
end
