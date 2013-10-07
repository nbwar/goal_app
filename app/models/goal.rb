class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :motivations, dependent: :destroy
  has_many :beliefs, dependent: :destroy

  validates_presence_of :title, :description
end
