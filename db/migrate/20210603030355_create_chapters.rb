class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.integer :article_id
      t.text :chapter_body
      t.string :chapter_image_id

      t.timestamps
    end
  end
end
