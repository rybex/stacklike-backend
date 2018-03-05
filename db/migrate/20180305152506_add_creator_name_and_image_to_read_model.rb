class AddCreatorNameAndImageToReadModel < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :creator_name,  :string, null: false
    add_column :questions, :creator_image, :string, null: false
  end
end
