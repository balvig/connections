module Connections
  module Connector
    extend ActiveSupport::Concern

    module ClassMethods
      def connects_with(*types)
        has_many :connections, :as => :connector, :dependent => :delete_all, :class_name => 'Connections::Connection'
        types.each do |t|
          class_eval do

            # user.follows, requires a Follow model
            has_many :"#{t.to_s.pluralize}", :as => :connector

            # user.follow(other_user)
            define_method t do |connectable|
              connection_class(t).create do |c|
                c.type = t.to_s.classify
                c.connector = self
                c.connectable = connectable
              end
            end

            # user.unfollow(other_user)
            define_method :"un#{t}" do |connectable|
              if Object.const_defined?(t.to_s.classify)
                connection_class(t).where(:connector_type => self.class.base_class, :connector_id => self).destroy_all
              else
                active_connections(t, connectable).delete_all
              end
            end

            # user.follows?(other_user)
            define_method :"#{t.to_s.pluralize}?" do |connectable|
              active_connections(t, connectable).exists?
            end

            # user.toggle_follow(other_user)
            define_method :"toggle_#{t}" do |connectable|
              if send("#{t.to_s.pluralize}?", connectable)
                send("un#{t}", connectable)
              else
                send(t, connectable)
              end
            end

            # user.following(:user)
            define_method :"#{t.to_s.sub(/e$/,'')}ing" do |*args|
              class_name = args.first
              if class_name
                klass = class_name.to_s.classify.constantize
                klass.joins(:incoming_connections).where("connections_connections.type = ? AND connector_type = ? AND connector_id = ?", t.to_s.classify, self.class.base_class.to_s, self)
              else
                connections.where('connections_connections.type = ?', t.to_s.classify)
              end
            end

          end
        end
      end
    end

    private

    def connection_class(type)
      Object.const_defined?(type.to_s.classify) ? type.to_s.classify.constantize : Connections::Connection
    end

    def active_connections(type, connectable)
      connections.where(:type => type.to_s.classify, :connectable_type => connectable.class.base_class, :connectable_id => connectable)
    end
  end
end

ActiveRecord::Base.send :include, Connections::Connector
