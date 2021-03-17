require 'rails_helper'

RSpec.describe Naver, type: :model do

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:birthdate) }
    it { should validate_presence_of(:admission_date) }
    it { should validate_presence_of(:job_role) }
  end
end