require 'test_helper'

class Admin::StructureOfRoomsControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get admin_structure_of_rooms_create_url
    assert_response :success
  end

  test 'should get update' do
    get admin_structure_of_rooms_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get admin_structure_of_rooms_destroy_url
    assert_response :success
  end
end
