require 'rails_helper'

RSpec.describe Supply, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:cinema_id) }
  end
end
