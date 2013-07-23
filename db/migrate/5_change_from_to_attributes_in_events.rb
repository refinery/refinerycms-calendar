class ChangeFromToAttributesInEvents < ActiveRecord::Migration
  def up

    add_column :refinery_calendar_events, :starts_at, :datetime
    add_column :refinery_calendar_events, :ends_at, :datetime

    Refinery::Calendar::Event.update_all "%s = %s" % [connection.quote_column_name(:starts_at), connection.quote_column_name(:from)]
    Refinery::Calendar::Event.update_all "%s = %s" % [connection.quote_column_name(:ends_at), connection.quote_column_name(:to)]

    remove_column :refinery_calendar_events, :from
    remove_column :refinery_calendar_events, :to

  end

  def down

    add_column :refinery_calendar_events, :from, :date
    add_column :refinery_calendar_events, :to, :date

    Refinery::Calendar::Event.update_all "%s = %s" % [connection.quote_column_name(:from), connection.quote_column_name(:starts_at)]
    Refinery::Calendar::Event.update_all "%s = %s" % [connection.quote_column_name(:to), connection.quote_column_name(:ends_at)]

    remove_column :refinery_calendar_events, :starts_at
    remove_column :refinery_calendar_events, :ends_at

  end
end
