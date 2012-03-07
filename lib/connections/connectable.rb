module Connections
  module Connectable
    extend ActiveSupport::Concern

    module ClassMethods
      def connectable_with(*types)
        has_many :incoming_connections, :as => :connectable, :dependent => :destroy, :class_name => 'Connections::Connection'
        types.each do |t|
          class_eval do

            # user.followers(:user)
            define_method :"#{t.to_s.sub(/e$/,'')}ers" do |class_name|
              klass = class_name.to_s.classify.constantize
              klass.joins(:connections).where("connections.type = ? AND connectable_type = ? AND connectable_id = ?", t.to_s.classify, self.class.table_name.classify, self)
            end
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Connections::Connectable
