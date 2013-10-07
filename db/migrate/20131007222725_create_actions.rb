class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :title
      t.text :description
      t.belongs_to :goal

      t.timestamps
    end
  end
end
