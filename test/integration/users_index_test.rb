require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @admin_user = users(:malory)
    @unactivated = users(:lana)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin_user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin_user
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  test "index as non-admin" do
    log_in_as(@user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end
