class CreateMotivations < ActiveRecord::Migration
  def change
    create_table :motivations do |t|
      t.string :title
      t.text :description
      t.boolean :positive
      t.belongs_to :goal

      t.timestamps
    end
  end
end
