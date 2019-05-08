module ManageAvailabilityPerHour
  extend ActiveSupport::Concern

  # def working_hours_new_set(force_create: false)
  #   return if per_hour_ready
  #   Listing::WorkingTimeSlot.week_days.keys.each do |week_day|
  #     next if ['sun', 'sat'].include?(week_day)
  #     if force_create
  #       working_time_slots.create(week_day: week_day, from: '09:00', till: '17:00')
  #       update_column(:per_hour_ready, true) # rubocop:disable Rails/SkipsModelValidations
  #     else
  #       working_time_slots.build(week_day: week_day, from: '09:00', till: '17:00')
  #     end
  #   end
  # end

  def working_hours_new_set(force_create: false)
    return if per_hour_ready
    dates_for_next_week = (Date.today..Date.today + 6)
    dates_for_next_week.each do |date|
      next if ['sun', 'sat'].include?(date.wday)
      if force_create
        working_date_slots.create(date: date, from: '09:00', till: '17:00')
        update_column(:per_hour_ready, true) # rubocop:disable Rails/SkipsModelValidations
      else
        working_date_slots.build(date: date, from: '09:00', till: '17:00')
      end
    end
  end

  def working_hours_as_json
    as_json(only: [:id, :title],  include: {
      working_time_slots: { only: [:id, :week_day, :from, :till], methods: :errors }
    })
  end

  def working_hours_covers_booking?(booking)
    author_working_time_slots.by_week_day(booking.week_day).each do |time_slot|
      return true if time_slot.covers_booking?(booking)
    end
    false
  end

  def working_hours_periods_grouped_by_day(start_time, end_time)
    working_hours_periods(start_time, end_time).group_by{ |x| x.start_time.to_date.to_s }
  end

  # returns multiple segments per day
  # <Biz::TimeSegment @start_time=2017-11-15 09:00:00 UTC, @end_time=2017-11-15 17:00:00 UTC>
  def working_hours_periods(start_time, end_time)
    if author_working_date_slots.any?
      working_hours_listing_schedule(start_time, end_time)
    else
      []
    end
  end

  private

  def working_hours_prepare_hash(start_time, end_time)
    result = {}
    day = {}
    author_working_date_slots.
      where("date >= ? AND date <= ?", start_time.to_date.to_s, Date.parse((start_time + 6).to_s).to_s).each do |time_slot|
        day[time_slot.from] = time_slot.till
        result[time_slot.date.wday.to_sym] = day unless day.empty?
    end
    result
  end

  def working_hours_shifts_prepare_hash(start_time, end_time)
    result = {}
    day = {}
    author_working_date_slots.
      where("date >= ? AND date <= ?", start_time.to_date, end_time.to_date).each do |time_slot|
        day[time_slot.from] = time_slot.till
        result[time_slot.date.to_s] = day unless day.empty?
    end
    result
  end

  def build_working_hours_listing_schedule(start_time, end_time)
    slots = author_working_date_slots.where("date >= ? AND date <= ?", start_time.to_date, end_time.to_date + 1)

    periods = slots.map do |slot|
      Biz::TimeSegment.new(slot.from_time, slot.till_time)
    end
  end

  def working_hours_listing_schedule(start_time, end_time)
    @working_hours_listing_schedule ||= \
      build_working_hours_listing_schedule(start_time, end_time)
  end

end
