class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def show
   @event = Event.find(params[:id])
  end


  def index
    @organization_events = Organization.find(params["organization_id"]).events
  end

  def create
    @event = Event.new(event_params)
    @organization = Organization.find(params["organization_id"])
    if @event.valid?
      @organization.events << @event
      flash[:notice] = "#{@event.name.titleize} has successfully been added to organization #{@organization.name}!"
      redirect_to organization_events_path(@organization)
    else
      flash[:notice] = "Error(s) while creating event:
      #{@event.errors.full_messages.to_sentence}"
      redirect_to new_organization_event_path(@organization)
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :date, :time, :location, :purpose)
    end

end

