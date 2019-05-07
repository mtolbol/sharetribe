class CreateListingWorkingDateSlot < ActiveRecord::Migration[5.1]
  def change
    create_table :listing_working_date_slots do |t|
      t.references :listing
      t.date :date
      t.string :from
      t.string :till

      t.timestamps
    end
  end
end
