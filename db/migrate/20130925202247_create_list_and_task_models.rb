class CreateListAndTaskModels < ActiveRecord::Migration
  def change
    create_table "lists" do |t|
      t.string :name
      t.datetime :archived_at

      t.timestamps
    end

    create_table "tasks" do |t|
      t.belongs_to :list
      t.text "text"
      t.datetime "due_date"
      t.datetime "finished_at"

      t.timestamps
    end
  end
end
