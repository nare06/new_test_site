class CreateEvents < ActiveRecord::Migration
  def self.up
      create_table :events do |t|
      t.string :title
      t.string :organizer
      t.string :location
      t.string :sdatetime
      t.string :edatetime
      t.string :eligibility
      t.string :contact_name
      t.string :contact_phone
      t.string :email
      t.string :events_description
      t.string :categories
      t.string :region

      t.timestamps

    end
  end
  def self.down
    drop_table :events
    end
end
