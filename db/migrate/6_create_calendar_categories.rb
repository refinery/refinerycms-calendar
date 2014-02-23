class CreateCalendarCategories < ActiveRecord::Migration

  def up
    create_table :refinery_calendar_categories do |t|
      t.string :name
      t.integer :position
      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-calendar"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/calendar/categories"})
    end

    drop_table :refinery_calendar_categories

  end

end
