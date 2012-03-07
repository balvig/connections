class User < ActiveRecord::Base
  connects_with :follow, :like
  connectable_with :follow
end
