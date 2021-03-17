class Naver < ApplicationRecord
  belongs_to :user

  validates :name, :birthdate, :admission_date, :job_role, presence: true
end
