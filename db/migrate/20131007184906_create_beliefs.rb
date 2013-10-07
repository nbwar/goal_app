class CreateBeliefs < ActiveRecord::Migration
  def change
    create_table :beliefs do |t|
      t.string :title
      t.string :description
      t.boolean :positive
      t.belongs_to :goal

      t.timestamps
    end
  end
end
