class CreateCalendarEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :calendar_events do |t|
      t.string :text
      t.text :description
      t.datetime :scheduled_for
      t.integer :user_id

      t.timestamps
    end
  end
end
