class FixGinIndexCreation < ActiveRecord::Migration[5.1]
  def up
    execute "DROP INDEX IF EXISTS questions_gin;"
    execute "CREATE INDEX questions_gin ON questions USING gin(to_tsvector('english'::regconfig, payload));"
  end

  def down
    execute "DROP INDEX questions_gin;"
  end
end
