class CreateIndexesForSearch < ActiveRecord::Migration[5.1]
  def change
    add_index :questions, "to_tsvector('english', title || ' ' || body)", using: :gin, name: 'questions_idx'
  end
end
