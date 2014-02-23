class CreateCalendarCategoryTranslations < ActiveRecord::Migration

  def self.up
    Refinery::Calendar::Category.create_translation_table!({
      name: :string,
    }, migrate_data: true)

  end

  def self.down

    Refinery::Calendar::Category.drop_translation_table! migrate_data: true

  end
end
