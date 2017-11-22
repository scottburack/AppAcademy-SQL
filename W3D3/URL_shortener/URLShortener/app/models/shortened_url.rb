class ShortenedUrl < ApplicationRecord
  include SecureRandom
  
  validates :long_url, presence: true
  validates :user_id, presence: true
  
  belongs_to :submitter,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  
  has_many :visits,
    class_name: 'Visit',
    foreign_key: :short_url_id,
    primary_key: :id 
    
  has_many :visitors,
    through: :visits,
    source: :user
    
    
  def self.random_code
    random = SecureRandom.urlsafe_base64
    
    while exists?(random)
      random = SecureRandom.urlsafe_base64
    end
    
    random
  end
  
  def self.create_user_url(user, long_url)
    ShortenedUrl.create!(
                      "user_id" => user.id, 
                      "long_url" => long_url, 
                      "short_url" => ShortenedUrl.random_code 
                    )
  end
  
  def num_clicks
    self.visitors.count
  end

    
end