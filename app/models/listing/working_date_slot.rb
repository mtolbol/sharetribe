# == Schema Information
#
# Table name: listing_working_date_slots
#
#  id         :integer          not null, primary key
#  date       :date
#  from       :string(255)
#  till       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :string(255)
#
# Indexes
#
#  index_listing_working_date_slots_on_person_id  (person_id)
#

# This class keeps track of the hours open for a
# given listing on a specific date
class Listing::WorkingDateSlot < ApplicationRecord
  belongs_to :person

  validate :from_is_less_than_till

  scope :by_date, ->(date) { where(date: date) }
  scope :ordered, -> { order('listing_working_date_slots.date ASC, listing_working_date_slots.from ASC') }

  def covers_booking?(booking)
    from_time = Time.zone.parse("#{date} #{from}")
    till_time = Time.zone.parse("#{date} #{till}")

    from_time <= booking.start_time && till_time >= booking.end_time
  end

  private

  def from_is_less_than_till
    from_time = Time.zone.parse("#{date} #{from}")
    till_time = Time.zone.parse("#{date} #{till}")
    if from_time >= till_time
      errors.add :from, :from_must_be_less_than_till
      errors.add :till, :from_must_be_less_than_till
    end
  end
end
