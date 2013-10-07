class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :motivations, dependent: :destroy
  has_many :beliefs, dependent: :destroy

  accepts_nested_attributes_for :motivations, :beliefs, :allow_destroy => true #, reject_if: proc { |attributes| attributes['title'].blank? }

  validates_presence_of :title
end
