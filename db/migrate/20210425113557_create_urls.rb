class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.text :link
      t.string :alias
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
