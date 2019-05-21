class WorkingDateSlotPresenter < MemoisticPresenter
  include ListingAvailabilityManage

  def time_slot_options
    (0..24).map do |x|
      value = format("%02d:00", x)
      name = I18n.locale == :en ? Time.parse("#{x}:00").strftime("%l:00 %P") : value # rubocop:disable Rails/TimeZone
      [name, value]
    end
  end
end
