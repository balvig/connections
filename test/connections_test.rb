require 'test_helper'

class ConnectionsTest < ActiveSupport::TestCase

  setup do
    @follower = User.create!
    @user = User.create!
    @post = Post.create!
  end

  # No explicit Follow class defined
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

  test '#following with arg' do
    @follower.follow(@user)
    @follower.follow(@post)
    assert_equal [@user], @follower.following(:user)
    assert_equal [@post], @follower.following(:post)
  end

  test '#following without arg' do
    @follower.follow(@user)
    @follower.follow(@post)
    assert_equal 2, @follower.following.size
  end

  test '#followers with arg' do
    @follower.follow(@user)
    @follower.follow(@post)
    assert_equal [@follower], @user.followers(:user)
    assert_equal [@follower], @post.followers(:user)
  end

  test '#followers without arg' do
    @follower.follow(@post)
    @user.follow(@post)
    assert_equal 2, @post.followers.size
  end

  test '#destroy cleans up connections' do
    @follower.follow(@user)
    @user.destroy
    assert_equal 0, Connections::Connection.count
    @follower.follow(@post)
    @follower.destroy
    assert_equal 0, Connections::Connection.count
  end

  # Explicit Like class defined
  test '#like' do
    assert !@user.likes?(@post)
    @user.like(@post)
    assert @user.likes?(@post)
  end

  test '#unlike' do
    like = @user.like(@post)
    assert_equal Like, like.class
    assert @user.likes?(@post)
    @user.unlike(@post)
    assert !@user.likes?(@post)
  end

  test '#toggle_like' do
    @user.toggle_like(@post)
    assert @user.likes?(@post)
    @user.toggle_like(@post)
    assert !@user.likes?(@post)
  end

  test '#liking' do
    @user.like(@post)
    assert_equal [@post], @user.liking(:post)
  end

  test '#likes' do
    @user.like(@post)
    assert_equal [@post], @user.likes.map(&:connectable)
  end

end
