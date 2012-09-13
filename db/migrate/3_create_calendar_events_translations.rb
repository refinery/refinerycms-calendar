class CreateCalendarEventsTranslations < ActiveRecord::Migration
  def up
    Refinery::Calendar::Event.create_translation_table!({
      :title => :string,
      :excerpt => :string,
      :description => :text,
      :slug => :string
    }, {
      :migrate_data => true
    })
  end

  def down
    Refinery::Calendar::Event.drop_translation_table! :migrate_data => true
  end
end