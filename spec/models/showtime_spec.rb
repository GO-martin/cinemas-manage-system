require 'rails_helper'

RSpec.describe Showtime, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:room_id) }
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:fare) }
  end
end
