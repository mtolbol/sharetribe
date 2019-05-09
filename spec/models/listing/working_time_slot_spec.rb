# == Schema Information
#
# Table name: listing_working_time_slots
#
#  id         :integer          not null, primary key
#  listing_id :integer
#  week_day   :integer
#  from       :string(255)
#  till       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_listing_working_time_slots_on_listing_id  (listing_id)
#

require 'spec_helper'

RSpec.describe Listing::WorkingTimeSlot, type: :model do
  describe ".ordered" do
    let!(:booking_later_day) { FactoryGirl.create(:listing_working_time_slot, :week_day => :fri, :from => "9:00", :till => "10:00") }
    let!(:booking_same_day) { FactoryGirl.create(:listing_working_time_slot, :week_day => :tue, :from => "9:00", :till => "10:00") }
    let!(:booking_same_day_later_hours) { FactoryGirl.create(:listing_working_time_slot, :week_day => :tue, :from => "11:00", :till => "12:00") }

    it "orders by date and from time" do
      expect(described_class.ordered).to eq([
        booking_same_day_later_hours,
        booking_same_day,
        booking_later_day
      ])
    end
  end

  describe "covers_booking?" do
    subject { FactoryGirl.create(:listing_working_time_slot, :week_day => :tue, :from => "9:00", :till => "10:00") }

    context "booking covers" do
      let!(:booking) { FactoryGirl.create(:booking, start_time: "2017-11-14 09:00", end_time: "2017-11-14 10:00", per_hour: true) }
      let!(:booking_different_day) { FactoryGirl.create(:booking, start_time: "2017-11-15 09:00", end_time: "2017-11-15 10:00", per_hour: true) }

      it "returns true" do
        expect(subject.covers_booking?(booking)).to be_truthy
      end

      it "returns true even when booking is on a different day" do
        # 2017-11-15 is wednesday, time slot is :tue(sday)
        expect(subject.covers_booking?(booking_different_day)).to be_truthy
      end
    end

    context "booking does not cover" do
      let!(:booking_different_time) { FactoryGirl.create(:booking, start_time: "2017-11-14 11:00", end_time: "2017-11-14 12:00", per_hour: true) }

      it "returns false when booking is on an uncovered time" do
        expect(subject.covers_booking?(booking_different_time)).to be_falsey
      end
    end
  end

  describe 'from till' do
    it 'Validates from is less than till' do
      working_time_slot = Listing::WorkingTimeSlot.new
      working_time_slot.from = '10:00'
      working_time_slot.till = '11:00'
      expect(working_time_slot.valid?).to eq true
      working_time_slot.from = '00:00'
      working_time_slot.till = '24:00'
      expect(working_time_slot.valid?).to eq true
      working_time_slot.from = '12:00'
      working_time_slot.till = '11:00'
      expect(working_time_slot.valid?).to eq false
      working_time_slot.from = '10:00'
      working_time_slot.till = '10:00'
      expect(working_time_slot.valid?).to eq false
    end
  end
end
