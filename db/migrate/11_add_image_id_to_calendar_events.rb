class AddImageIdToCalendarEvents < ActiveRecord::Migration

 def change
    add_column :refinery_calendar_events, :image_id, :integer
  end

end
