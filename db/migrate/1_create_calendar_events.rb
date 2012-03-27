class CreateCalendarEvents < ActiveRecord::Migration

  def up
    create_table :refinery_calendar_events do |t|
      t.string :title
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-calendar"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/calendar/events"})
    end

    drop_table :refinery_calendar_events

  end

end
