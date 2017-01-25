require 'test_helper'

class UserIDsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_id = user_ids(:one)
  end

  test "should get index" do
    get user_ids_url
    assert_response :success
  end

  test "should get new" do
    get new_user_id_url
    assert_response :success
  end

  test "should create user_id" do
    assert_difference('UserId.count') do
      post user_ids_url, params: { user_id: { Last: @user_id.Last, id: @user_id.id, username: @user_id.username } }
    end

    assert_redirected_to user_id_url(UserId.last)
  end

  test "should show user_id" do
    get user_id_url(@user_id)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_id_url(@user_id)
    assert_response :success
  end

  test "should update user_id" do
    patch user_id_url(@user_id), params: { user_id: { Last: @user_id.Last, id: @user_id.id, username: @user_id.username } }
    assert_redirected_to user_id_url(@user_id)
  end

  test "should destroy user_id" do
    assert_difference('UserId.count', -1) do
      delete user_id_url(@user_id)
    end

    assert_redirected_to user_ids_url
  end
end
