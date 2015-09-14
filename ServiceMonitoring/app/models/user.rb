class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :validatable, :trackable, :recoverable
end
