class CreateEventCategorizations < ActiveRecord::Migration
  def self.up
    create_table :categories_events, id: false do |t|
      t.integer :event_id
      t.integer :category_id
    end

    # add_index :categories_events, :refinery_calendar_event_id
    # add_index :categories_events, :refinery_calendar_category_id
  end

  def self.down
    drop_table :categories_events
  end
end
