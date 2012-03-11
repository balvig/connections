module Connections
  class Connection < ActiveRecord::Base
    belongs_to :connector, :polymorphic => true
    belongs_to :connectable, :polymorphic => true

    validates_uniqueness_of :connectable_type, :scope => [:connectable_id, :connector_type, :connector_id, :type]

    attr_accessible
  end
end
