class NaverSerializer < ActiveModel::Serializer
  attributes :id, :name, :birthdate, :admission_date, :job_role
  has_many :projects
end
