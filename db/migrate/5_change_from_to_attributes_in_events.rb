class ChangeFromToAttributesInEvents < ActiveRecord::Migration
  def up

    add_column :refinery_calendar_events, :starts_at, :datetime
    add_column :refinery_calendar_events, :ends_at, :datetime

    Refinery::Calendar::Event.update_all '"starts_at" = "from", "ends_at" = "to"'

    remove_column :refinery_calendar_events, :from, :datetime
    remove_column :refinery_calendar_events, :to, :datetime

  end

  def down

    add_column :refinery_calendar_events, :starts_at, :datetime
    add_column :refinery_calendar_events, :ends_at, :datetime

    Refinery::Calendar::Event.update_all '"starts_at" = "from", "ends_at" = "to"'

    remove_column :refinery_calendar_events, :from, :datetime
    remove_column :refinery_calendar_events, :to, :datetime

  end
end