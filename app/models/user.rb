class User < ApplicationRecord
  has_many :albums, :dependent => :restrict_with_error
end
