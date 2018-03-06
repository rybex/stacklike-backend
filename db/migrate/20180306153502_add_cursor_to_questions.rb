class AddCursorToQuestions < ActiveRecord::Migration[5.1]
  def up
    execute "CREATE SEQUENCE questions_cursor_seq START 1"
    add_column :questions, :cursor, :integer
    execute "ALTER TABLE questions ALTER COLUMN cursor SET DEFAULT nextval('questions_cursor_seq');"
  end

  def down
    execute "DROP SEQUENCE questions_cursor_seq;"
    drop_column :questions, :cursor
  end
end
