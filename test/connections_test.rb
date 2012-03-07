require 'test_helper'

class ConnectionsTest < ActiveSupport::TestCase

  setup do
    @follower = User.create!
    @user = User.create!
    @post = Post.create!
  end

  test '#follow' do
    @follower.follows?(@user).should be_false
    @follower.follow(@user)
    @follower.follows?(@user).should be_true
  end

  test '#unfollow' do
    @follower.follow(@user)
    @follower.follows?(@user).should be_true
    @follower.unfollow(@user)
    @follower.follows?(@user).should be_false
  end

  test '#toggle_follow' do
    @follower.toggle_follow(@user)
    @follower.follows?(@user).should be_true
    @follower.toggle_follow(@user)
    @follower.follows?(@user).should be_false
  end

  test '#following' do
    @follower.follow(@user)
    @follower.follow(@post)
    @follower.following(:user).should == [@user]
    @follower.following(:post).should == [@post]
  end

  #test '#follows' do
    #@follower.follow(@user)
    #@follower.follow(book)
    #@follower.like(Factory(:post))
    #@follower.follows.map(&:connectable).should == [@user, book]
  #end

end
