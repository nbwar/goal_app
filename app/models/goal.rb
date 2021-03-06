class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :motivations, dependent: :destroy
  has_many :beliefs, dependent: :destroy
  has_many :actions, dependent: :destroy

  accepts_nested_attributes_for :motivations, :beliefs, :actions, :allow_destroy => true #, reject_if: proc { |attributes| attributes['title'].blank? }

  validates_presence_of :title
end
