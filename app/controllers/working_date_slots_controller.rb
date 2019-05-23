class WorkingDateSlotsController < ApplicationController
  def index
    @working_date_slots = @current_user.working_date_slots
    @working_date_slot = Listing::WorkingDateSlot.new
  end

  def create
    @working_date_slot = Listing::WorkingDateSlot.new(working_date_params)

    if @working_date_slot.save
      return redirect_to(working_date_slots_path)
    else
      @working_date_slots = @current_user.working_date_slots
      render :index
    end
  end

  def edit
    @working_date_slot = @current_user.working_date_slots.find(params[:id])
  end

  def update
    @working_date_slot = @current_user.working_date_slots.find(params[:id])
    if @working_date_slot.update(working_date_params)
      redirect_to(working_date_slots_path)
    else
      render :edit
    end
  end

  private

  def working_date_params
    params.
      require(:listing_working_date_slot).
      permit(
        :date,
        :from,
        :person_id,
        :till
      )
  end
end
