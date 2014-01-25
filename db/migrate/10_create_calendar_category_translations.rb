class CreateCalendarCategoryTranslations < ActiveRecord::Migration

  def self.up
    Refinery::Calendar::Category.create_translation_table!({
      name: :string,
    }, migrate_data: true)

    remove_column :refinery_calendar_categories, :name
  end

  def self.down
    add_column :refinery_calendar_categories, :name, :string

    Refinery::Calendar::Category.drop_translation_table! migrate_data: true

  end
end
