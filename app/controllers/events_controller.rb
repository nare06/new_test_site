class EventsController < ApplicationController
before_filter :authenticate_user!, except: [:show, :index] #:only: [:new, :create ,:blah]
 def show
   @event = Event.find(params[:id])
  end

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @events = Event.all.paginate :page => params[:page], :per_page => 2
  end

  # GET /events/1
  # GET /events/1.json
# before_filter :authenticate_user!
  # GET /events/new
  def new
  
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
  if signed_in?
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
end
   else 
       redirect_to signin_path
       flash[:notice] = 'Please signin first'
   end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
def display
  conditions = []
  conditions << [ "in_production = ?", params[:in_production] ] if params[:in_production].present?
  conditions << [ "year = ?", params[:year] ] if params[:year].present?
  conditions << [ "make = ?", params[:make] ] if params[:make].present?
  @event = Event.all(:conditions => conditions )
end
  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    if @event.present?
    @event.destroy
    end
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title,:organizer,:location,
                                      :sdatetime,:edatetime,:eligibility,:contact_name,
                                      :contact_phone, :email,
                                     :events_description,:categories,:region)
    end
end
