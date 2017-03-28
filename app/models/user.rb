class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable, stretches: 12

end
