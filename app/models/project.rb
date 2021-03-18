class Project < ApplicationRecord
  has_and_belongs_to_many :navers

  validates :name, presence: true
  validates :name, uniqueness: true
end
