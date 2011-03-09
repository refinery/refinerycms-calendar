class CreateEventCategorizations < ActiveRecord::Migration
  def self.up
    create_table :event_categorizations do |t|
      t.integer :event_id
      t.integer :event_category_id
      
      t.timestamps
    end
    
    add_index :event_categorizations, :event_id
    add_index :event_categorizations, :event_category_id
  end

  def self.down
    drop_table :event_categorizations
  end
end
