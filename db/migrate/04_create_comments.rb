class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name, :limit => 50, :default => "" 
      t.text :comment
      t.references :commentable, :polymorphic => true
      t.timestamps
    end

    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
  end

  def self.down
    drop_table :comments
  end
end
