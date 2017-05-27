require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  #
  #
  # Setup
  def setup
    @user       = users(:michael)
    @other_user = users(:john)
  end

  #
  #
  # Users List
  test 'should redirect index when not logged in' do
    get users_path
    assert_redirected_to login_url
  end

  #
  #
  # New
  test 'should get new' do
    get signup_path
    assert_response :success
  end

  #
  #
  #
  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  #
  #
  #
  test 'should redirect update when not logged in' do
    patch user_path(@user), params: {
        user: {
            name: @user.name,
            email: @user.email
        }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  #
  #
  # Other User Logged-in
  test 'should redirect edit when logged in as other user' do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  #
  #
  #
  test 'should redirect update when logged in as other user' do
    log_in_as(@other_user)
    patch user_path(@user), params: {
        user: {
            name: @user.name,
            email: @user.email
        }
    }
    assert flash.empty?
    assert_redirected_to root_url
  end

  #
  #
  # Destroy - User Not logged-in
  test 'should redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      delete user_path(@user), params: {
          id: @user
      }
    end
    assert_redirected_to login_url
  end

  #
  #
  # Destroy - User logged-in as a non-admin
  test 'should redirect destroy when logged-in as a non-admin' do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@other_user), params: {
          id: @other_user
      }
    end
    assert_redirected_to root_url
  end


end
