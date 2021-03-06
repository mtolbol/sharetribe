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

require 'spec_helper'

RSpec.describe Listing::WorkingDateSlot, type: :model do
  subject { FactoryGirl.build(:listing_working_date_slot) }

  it { should belong_to(:person) }

  describe ".ordered" do
    let!(:booking_later_date) { FactoryGirl.create(:listing_working_date_slot, :date => "2017-11-28", :from => "9:00", :till => "10:00") }
    let!(:booking_same_day) { FactoryGirl.create(:listing_working_date_slot, :date => "2017-11-14", :from => "9:00", :till => "10:00") }
    let!(:booking_same_day_later_hours) { FactoryGirl.create(:listing_working_date_slot, :date => "2017-11-14", :from => "11:00", :till => "12:00") }

    it "orders by date and from time" do
      expect(described_class.ordered).to eq([
        booking_same_day_later_hours,
        booking_same_day,
        booking_later_date
      ])
    end
  end

  describe "covers_booking?" do
    subject { FactoryGirl.create(:listing_working_date_slot, :date => "2017-11-14", :from => "9:00", :till => "10:00") }

    context "booking covers" do
      let!(:booking) { FactoryGirl.create(:booking, start_time: '2017-11-14 09:00', end_time: '2017-11-14 10:00', per_hour: true) }

      it "returns true" do
        expect(subject.covers_booking?(booking)).to be_truthy
      end
    end

    context "booking does not cover" do
      let!(:booking) { FactoryGirl.create(:booking, start_time: '2017-11-15 09:00', end_time: '2017-11-15 10:00', per_hour: true) }
      let!(:booking_different_time) { FactoryGirl.create(:booking, start_time: '2017-11-14 11:00', end_time: '2017-11-14 12:00', per_hour: true) }

      it "returns false when booking is on another date" do
        expect(subject.covers_booking?(booking)).to be_falsey
      end

      it "returns false when booking is on an uncovered time" do
        expect(subject.covers_booking?(booking_different_time)).to be_falsey
      end
    end
  end

  describe "#conflicts_with_other validation" do
    let!(:person) { FactoryGirl.create(:person) }
    let!(:date_slot) do
      create_slot(person, "2017-11-14", "9:00", "12:00")
    end

    context "when dates conflicts" do
      let(:same_time_slot) do
        build_slot(person, "2017-11-14", "9:00", "12:00")
      end

      it "is not valid when from and till times are an exact match" do
        expect(same_time_slot).to_not be_valid
      end

      it "is not valid when from is within existing time period" do
        same_time_slot.from = "10:00"
        same_time_slot.till = "14:00"

        expect(same_time_slot).to_not be_valid
      end

      it "is not valid when till is within existing time period" do
        same_time_slot.from = "8:00"
        same_time_slot.till = "10:00"

        expect(same_time_slot).to_not be_valid
      end

      context "when new date slot is for another person" do
        let!(:other_person) { FactoryGirl.create(:person) }

        context "and the dates are exactly like existing time slot" do
          let(:same_time_slot_another_person) do
            build_slot(other_person, "2017-11-14", "9:00", "12:00")
          end

          it "is valid" do
            expect(same_time_slot_another_person).to be_valid
          end
        end
      end
    end

    context "when new slot does not conflict with existing working date slot" do
      let(:different_time_slot) do
        build_slot(person, "2017-11-14", "9:00", "10:00")
      end

      it "is valid when on different dates" do
        different_time_slot.date = "2017-11-15"
        expect(different_time_slot).to be_valid
      end

      it "is valid when same date but in a later time period" do
        different_time_slot.from = "13:00"
        different_time_slot.till = "14:00"
        expect(different_time_slot).to be_valid
      end

      it "is valid when same date but in an earlier time period" do
        different_time_slot.from = "7:00"
        different_time_slot.till = "8:00"
        expect(different_time_slot).to be_valid
      end
    end

    private

    def build_slot(person, date, from, till)
      FactoryGirl.build(
        :listing_working_date_slot,
        :date => date,
        :from => from,
        :person => person,
        :till => till
      )
    end

    def create_slot(person, date, from, till)
      build_slot(person, date, from, till).save!
    end
  end

  describe 'from till' do
    it 'Validates from is less than till' do
      working_date_slot = Listing::WorkingDateSlot.new
      working_date_slot.from = '10:00'
      working_date_slot.till = '11:00'
      expect(working_date_slot.valid?).to eq true
      working_date_slot.from = '00:00'
      working_date_slot.till = '24:00'
      expect(working_date_slot.valid?).to eq true
      working_date_slot.from = '12:00'
      working_date_slot.till = '11:00'
      expect(working_date_slot.valid?).to eq false
      working_date_slot.from = '10:00'
      working_date_slot.till = '10:00'
      expect(working_date_slot.valid?).to eq false
    end
  end
end
