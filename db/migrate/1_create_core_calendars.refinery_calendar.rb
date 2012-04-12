class CreateCoreCalendars < ActiveRecord::Migration
  def self.up
    create_table :core_calendars do |t|
      t.string :app
      t.timestamps
    end
  end
  def self.down
    drop_table :core_calendars
  end
end

