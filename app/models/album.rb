class Album < ApplicationRecord
  belongs_to :user
  has_many :photos, :dependent => :restrict_with_error
end
