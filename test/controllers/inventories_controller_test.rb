require "test_helper"

class InventoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get inventories_new_url
    assert_response :success
  end

  test "should get create" do
    get inventories_create_url
    assert_response :success
  end
end
