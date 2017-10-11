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
    user = users(:user_0)
    other_user   = users(:user_1)

    log_in_as(user)

    following_count = user.following.count
    followers_count = user.followers.count
    get root_path
    assert_select '#following', text: following_count.to_s
    assert_select '#followers', text: followers_count.to_s

    user.follow(other_user)
    get root_path
    assert_select '#following', text: (following_count + 1).to_s
    assert_select '#followers', text: followers_count.to_s

    other_user.follow(user)
    get root_path
    assert_select '#following', text: (following_count + 1).to_s
    assert_select '#followers', text: (followers_count + 1).to_s

    user.unfollow(other_user)
    get root_path
    assert_select '#following', text: following_count.to_s
    assert_select '#followers', text: (followers_count + 1).to_s

    other_user.unfollow(user)
    get root_path
    assert_select '#following', text: following_count.to_s
    assert_select '#followers', text: followers_count.to_s
  end
end
