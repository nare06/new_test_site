Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET'] 
    {
      
    }

  provider :twitter, ENV['TWITTER_ID'], ENV['TWITTER_SECRET']
    {
      secure_image_url: 'true'
    }
   
  provider :google_oauth2,ENV['GOOGLE_ID'], ENV['GOOGLE_SECRET'] 
    {
      name: "google_login", 
      approval_prompt: ''
    }
    provider :browser_id
    {
    }
    
end
