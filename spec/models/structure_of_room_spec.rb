require 'rails_helper'

RSpec.describe StructureOfRoom, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:row_index) }
    it { should validate_presence_of(:column_index) }
    it { should validate_presence_of(:room_id) }
    it { should validate_presence_of(:type_seat) }
  end

  describe 'associations' do
    it { should belong_to(:room) }
  end
end
