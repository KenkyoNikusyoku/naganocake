class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|

    # ここから下を追加
      t.string :name, null: false
      t.boolean :is_valid, default:true, null: false
    # ここから上を追加

      t.timestamps
    end
  end
end
