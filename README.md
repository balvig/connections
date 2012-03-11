# Connections

Most social apps needs some kind of follow/like/watch/stalk/etc
feature that connects one model to another.

Instead of having to recreate this functionality for every project we
decided to create a gem that easily allows you to add these features
using any naming you prefer.

## Installation

Add the gem to the gemfile:
`gem "connections"`

Install migration:
`rake connections:install:migrations`

This generates a migration that creates a single join table for
keeping track of what is connected to what.

## Usage

Use `connects_with` and `connectable_with` to add connection capabilities to any model using
whatever naming scheme you prefer (follow, like, watch, etc)

    class User < ActiveRecord::Base
      connects_with :follow, :like
      connectable_with :follow
    end

    class Post < ActiveRecord::Base
      connectable_with :like
    end

This will add following methods:

    # Follow
    user.follow(other_user) # Creates a 'Follow' connection from user -> other_user
    user.unfollow(other_user) # Removes 'Follow' connection between user -> other_user
    user.toggle_follow(other_user) # Toggles the connection on/off (useful for toggle buttons)
    user.follows?(other_user) # Returns true if the user if following other_user
    user.followings(:user) # Returns a list of all the users the user is following
    other_user.followers(:user) #Returns a list of all the user's followers

    # Like
    user.like(post)
    user.unlike(post)
    user.toggle_like(post)
    user.likes?(post)
    user.likings(:post)
    post.likers(:user)

That's it! If you want to add extra functionality to the join model (such
as using callbacks etc) you can explicitly define the model in your
project like this:

    class Follow < Connections::Connection
      ...
    end

## Credits

This gem was inspired by [socialization](https://github.com/cmer/socialization) that although it didn't quite do what we needed is a pretty useful tool.


## Copyright

Copyright (c) 2012 Jens Balvig --  Released under the MIT license.
