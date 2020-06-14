class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|

    # ここから下を追加
      t.integer :member_id, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :receiver, null: false
    # ここから上を追加

      t.timestamps
    end
  end
end
