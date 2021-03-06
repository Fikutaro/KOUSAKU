class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :article_id
      t.text :comment_content
      t.string :comment_image_id

      t.timestamps
    end
  end
end
