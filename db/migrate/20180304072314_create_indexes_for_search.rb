class CreateIndexesForSearch < ActiveRecord::Migration[5.1]
  def up
    execute "CREATE INDEX questions_gin ON questions USING gin(to_tsvector('english', payload));"
  end

  def down
    execute "DROP INDEX questions_gin;"
  end
end
