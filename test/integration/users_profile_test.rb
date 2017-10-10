require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

  test "follow count" do
    log_in_as(@user)
    get root_path
    assert_select '#following', text: "0"
    assert_select '#followers', text: "0"

    archer   = users(:archer)

    @user.follow(archer)
    get root_path
    assert_select '#following', text: "1"
    assert_select '#followers', text: "0"

    archer.follow(@user)
    get root_path
    assert_select '#following', text: "1"
    assert_select '#followers', text: "1"

    @user.unfollow(archer)
    get root_path
    assert_select '#following', text: "0"
    assert_select '#followers', text: "1"

    archer.unfollow(@user)
    get root_path
    assert_select '#following', text: "0"
    assert_select '#followers', text: "0"
  end
end
