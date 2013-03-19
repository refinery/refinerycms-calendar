class ChangeFromToAttributesInEvents < ActiveRecord::Migration
  def up

    add_column :refinery_calendar_events, :starts_at, :datetime
    add_column :refinery_calendar_events, :ends_at, :datetime

    Refinery::Calendar::Event.update_all '`starts_at` = `from`, `ends_at` = `to`'

    remove_column :refinery_calendar_events, :from
    remove_column :refinery_calendar_events, :to

  end

  def down

    add_column :refinery_calendar_events, :from, :date
    add_column :refinery_calendar_events, :to, :date

    Refinery::Calendar::Event.update_all '`from` = `starts_at`, `to` = `ends_at`'

    remove_column :refinery_calendar_events, :starts_at
    remove_column :refinery_calendar_events, :ends_at

  end
end