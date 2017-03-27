class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, stretches: 12
end
