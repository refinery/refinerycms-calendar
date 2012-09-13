class CreateCalendarVenuesTranslations < ActiveRecord::Migration
  def up
    Refinery::Calendar::Venue.create_translation_table!({
      :name => :string
    }, {
      :migrate_data => true
    })
  end

  def down
    Refinery::Calendar::Venue.drop_translation_table! :migrate_data => true
  end
end