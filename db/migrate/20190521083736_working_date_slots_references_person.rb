class WorkingDateSlotsReferencesPerson < ActiveRecord::Migration[5.1]
  def change
    remove_reference :listing_working_date_slots, :listing, :index => true
    add_reference :listing_working_date_slots, :person, :type => :string, :index => true
  end
end
