class CreatePostTags < ActiveRecord::Migration[5.1]
  def change
    create_table :post_tags do |t|
      # t.references :post, foreign_key: true
      # t.references :tag, foreign_key: true
      t.integer :tag_id
      t.integer :post_id
      t.timestamps
    end
  end
end
