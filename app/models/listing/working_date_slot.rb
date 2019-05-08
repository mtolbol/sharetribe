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
  validate :conflicts_with_other

  enum week_day: {sun: 0, mon: 1, tue: 2, wed: 3, thu: 4, fri: 5, sat: 6}

  scope :by_date, ->(date) { where(date: date) }
  scope :ordered, -> { order('listing_working_date_slots.date ASC, listing_working_date_slots.from ASC') }

  class << self
    def conflicting(slot)
      collection = \
        where.not(:id => slot.id)
        .where(:person_id => slot.person_id)
        .by_date(slot.date)
        .select { |other| slot.conflicts?(other) }

      # return activerecord collection in case further scoping is needed
      where(:id => collection)
    end
  end

  def conflicts?(other)
    other_time_range = (other.from_time..other.till_time)
    (from_time..till_time).overlaps?(other_time_range)
  end

  def covers_booking?(booking)
    from_time <= booking.start_time && till_time >= booking.end_time
  end

  def from_time
    Time.zone.parse("#{date} #{from}")
  end

  def till_time
    Time.zone.parse("#{date} #{till}")
  end

  private

  def conflicts_with_other
    if self.class.conflicting(self).any?
      errors.add :from, :conflicts_with_other
      errors.add :till, :conflicts_with_other
    end
  end

  def from_is_less_than_till
    if from_time >= till_time
      errors.add :from, :from_must_be_less_than_till
      errors.add :till, :from_must_be_less_than_till
    end
  end
end
