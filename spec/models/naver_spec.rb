require 'rails_helper'

RSpec.describe Naver, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:projects).through(:naver_projects) }
    it { should have_many(:naver_projects) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:birthdate) }
    it { should validate_presence_of(:admission_date) }
    it { should validate_presence_of(:job_role) }
  end
end
