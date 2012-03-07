require 'test_helper'

class ConnectionsTest < ActiveSupport::TestCase

  setup do
    @follower = User.create!
    @user = User.create!
    @post = Post.create!
  end

  test '#follow' do
    assert !@follower.follows?(@user)
    @follower.follow(@user)
    assert @follower.follows?(@user)
  end

  test '#unfollow' do
    @follower.follow(@user)
    assert @follower.follows?(@user)
    @follower.unfollow(@user)
    assert !@follower.follows?(@user)
  end

  test '#toggle_follow' do
    @follower.toggle_follow(@user)
    assert @follower.follows?(@user)
    @follower.toggle_follow(@user)
    assert !@follower.follows?(@user)
  end

  test '#following' do
    @follower.follow(@user)
    @follower.follow(@post)
    assert_equal [@user], @follower.following(:user)
    assert_equal [@post], @follower.following(:post)
  end

  test '#follows' do
    assert !@user.respond_to?(:follows)
  end

end
