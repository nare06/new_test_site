class Event < ActiveRecord::Base
#attr_accessor :upload, :edate, :contact_phone
attr_accessible :title,:organizer,:location,
                            :sdatetime,:edatetime,:eligibility,:contact_name ,
                           :contact_phone, :email,
                            :events_description,:categories,:region
                                 
validates :title, :presence => true, length: {maximum: 50}
validates :sdatetime, :presence => true, length: {minimum: 19}
validates :organizer, :presence => true
validates :events_description, :presence => true
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
			uniqueness: {case_sensitive: false}
end
