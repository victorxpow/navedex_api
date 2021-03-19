require 'rails_helper'

RSpec.describe NaverProject, type: :model do
  it { should belong_to(:naver) }
  it { should belong_to(:project) }
end
