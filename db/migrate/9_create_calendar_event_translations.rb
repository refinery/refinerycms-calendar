class CreateCalendarEventTranslations < ActiveRecord::Migration

  def self.up
    Refinery::Calendar::Event.create_translation_table!({
      title: :string,
      excerpt: :string,
      description: :text
    }, migrate_data: true)

    remove_column :refinery_calendar_events, :title
    remove_column :refinery_calendar_events, :excerpt
    remove_column :refinery_calendar_events, :description
  end

  def self.down
    add_column :refinery_calendar_events, :title, :string
    add_column :refinery_calendar_events, :excerpt, :string
    add_column :refinery_calendar_events, :description, :text

    CalendarEvents.drop_translation_table! migrate_data: true
  end
end
