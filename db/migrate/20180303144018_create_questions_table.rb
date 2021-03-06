class CreateQuestionsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :questions, id: :uuid do |t|
      t.uuid   :creator_id, null: false
      t.string :title,      null: false
      t.string :body,       null: false
      t.jsonb  :answers,    null: false

      t.timestamps
    end
  end
end
