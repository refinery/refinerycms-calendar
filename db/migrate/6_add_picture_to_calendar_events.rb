class AddPictureToCalendarEvents < ActiveRecord::Migration
  def change
    add_column :refinery_calendar_events, :picture_id, :integer
  end
end