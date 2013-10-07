class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.string :description
      t.belongs_to :user

      t.timestamps
    end
  end
end
