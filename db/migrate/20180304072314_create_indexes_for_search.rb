class CreateIndexesForSearch < ActiveRecord::Migration[5.1]
  def change
    add_index :questions, "to_tsvector('english', payload)", using: :gin, name: 'questions_idx'
  end
end
