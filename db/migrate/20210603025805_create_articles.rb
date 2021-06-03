class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.string :article_image_id
      t.text :preface
      t.text :body
      t.text :material
      t.text :production_time
      t.integer :difficulty, default: 0

      t.timestamps
    end
  end
end
