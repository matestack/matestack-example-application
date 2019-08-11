class User
  attr_accessor :id, :username

  def initialize(attributes)
    self.id = attributes[:id]
    self.username = attributes[:username]
  end

  def self.find(cuid)
    user_details = Rails.cache.read("#{Date.today.to_s}_users").find{|user| user[:id] == cuid}
    return User.new(username: 'anonymous') if user_details.nil?

    User.new(user_details)
  end

  def save
    users = Rails.cache.read("#{Date.today.to_s}_users") || []
    users << {id: self.id , username: self.username}
    Rails.cache.write("#{Date.today.to_s}_users", users)
  end
end
