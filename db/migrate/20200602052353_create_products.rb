class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

    # ここから下を追加
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :introduction
      t.integer :price, null: false
      t.string :image_id
      t.boolean :is_valid, default:true, null: false
    # ここから上を追加

      t.timestamps
    end
  end
end
