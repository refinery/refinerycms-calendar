class AddCachedSlugs < ActiveRecord::Migration
  def self.up
    add_column :event_categories, :cached_slug, :string
    add_column :events, :cached_slug, :string
  end

  def self.down
    remove_column :event_categories, :cached_slug
    remove_column :events, :cached_slug
  end
end
