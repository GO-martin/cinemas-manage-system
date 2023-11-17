require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cinema_id) }
    it { should validate_presence_of(:row_size) }
    it { should validate_presence_of(:column_size) }
  end
end
