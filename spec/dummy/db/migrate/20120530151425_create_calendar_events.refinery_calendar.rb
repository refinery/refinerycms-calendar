# This migration comes from refinery_calendar (originally 1)
class CreateCalendarEvents < ActiveRecord::Migration

  def up
    create_table :refinery_calendar_events do |t|
      t.string :title
      t.date :from
      t.date :to
      t.string :registration_link
      t.string :excerpt
      t.text :description
      t.integer :position
      t.boolean :featured
      t.string :slug
      t.integer :venue_id

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
