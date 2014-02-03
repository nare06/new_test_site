class StaticPagesController < ApplicationController
  def home
    #@title = "Home"
    @events = Event.all
    @events = Event.all.paginate :page => params[:page], :per_page => 5
  end
  def about
   # @title = "About"
  end
  def contact
   # @title = "Contact"
  end
  def help
   # @title = "Help"
  end
  def faq
  
  end
  def all_services
  end
end
