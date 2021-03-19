class Naver < ApplicationRecord
  belongs_to :user
  has_many :naver_projects
  has_many :projects, through: :naver_projects

  validates :name, :birthdate, :admission_date, :job_role, presence: true
end
