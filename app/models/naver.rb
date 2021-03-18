class Naver < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :projects, optional: true

  validates :name, :birthdate, :admission_date, :job_role, presence: true
end
