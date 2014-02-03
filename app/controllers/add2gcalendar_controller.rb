class Add2gcalendarController < ApplicationController

def create  
  @event = Event.find(params[:id])
      
  @auth = request.env["omniauth.auth"]
  @token = @auth["credentials"]["token"]
  client = Google::APIClient.new
  client.authorization.access_token = @token
  service = client.discovered_api('calendar', 'v3')
  @result = client.execute(
    :api_method => service.calendars.insert,
    :parameters => # not sure what parameters the insert needs,
    :body => JSON.dump(cal), # where cal is the object containing at least "summary".
    :headers => {'Content-Type' => 'application/json'})
end

end
