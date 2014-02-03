class User < ActiveRecord::Base
  # You can add other devise modules here as arguments, as in devise calls. :omniauthable module is always added
  # and forbidden devise modules are automatically removed (see GoogleAuthentication::ActsAsGoogleUser::FORBIDDEN_MODULES)
  # if you change this line, remember to edit the generated migration
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable 
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
 # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable devise :database_authenticatable, :registerable,
      #   :recoverable, :rememberable, :trackable, :validatable, 
#attr_accessor :password
attr_accessible :name, :email, :password, :password_confirmation
has_many :microposts, :dependent => :destroy
has_many :relationships, :foreign_key => "follower_id",
                         :dependent => :destroy
has_many :following, :through => :relationships, :source => :followed
has_many :reverse_relationships, :foreign_key => "followed_id",
                          :class_name  =>"Relationship",               
                          :dependent => :destroy
has_many :followers, :through => :reverse_relationships, :source => :follower
 
 def self.find_for_facebook_oauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[6,20]
    user.name = auth.info.name   # assuming the user model has a name
    user.save!
  end
end
 def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  def self.find_for_google_oauth2(data, singed_in_resource=nil)

  user= User.where(:email => data.info["email"]).first
      unless user
        user = User.create(name: data.info["name"],
             email: data.info["email"],
             password: Devise.friendly_token[6,20],
             uid: data["uid"],
             provider: data["provider"]            
            )
    end
    user
end
private
def following?(followed)
  relationships.find_by_followed_id(followed)
end
def follow!(followed)
  relationships.create!(:followed_id => followed.id)
end
def unfollow!(followed)
  relationships.find_by_followed_id(followed).destroy
end
end
