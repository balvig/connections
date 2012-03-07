require 'test_helper'

class ConnectionsTest < ActiveSupport::TestCase

  setup do
    @follower = User.create!
    @user = User.create!
    @post = Post.create!
  end

  context 'No Follow class defined for join table' do
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
      #TODO: What should happen if the Follow model isn't defined?
      #assert !@user.respond_to?(:follows)
    end

    test '#followers' do
      @follower.follow(@user)
      @follower.follow(@post)
      assert_equal [@follower], @user.followers(:user)
      assert_equal [@follower], @post.followers(:user)
    end
  end

  context 'Like class defined for join table' do

    test '#like' do
      assert !@user.likes?(@post)
      @user.like(@post)
      assert @user.likes?(@post)
    end

    test '#unlike' do
      @user.like(@post)
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

end
