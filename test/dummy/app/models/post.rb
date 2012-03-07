class Post < ActiveRecord::Base
  connectable_with :follow, :like
end
