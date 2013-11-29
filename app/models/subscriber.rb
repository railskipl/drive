class Subscriber < ActiveRecord::Base
   attr_accessible :subscriber_id,:subscriber_type,:subscribale_id,:subscribale_type

   belongs_to :subscriber,   :polymorphic => true
      belongs_to :subscribable, :polymorphic => true

      scope :subscribed_by, lambda { |subscriber| where(
        :subscriber_type   => subscriber.class.table_name.classify,
        :subscriber_id     => subscriber.id)
      }

      scope :subscribing,   lambda { |subscribable| where(
        :subscribable_type => subscribable.class.table_name.classify,
        :subscribable_id   => subscribable.id)
      }


        def self.subscribe!(subscriber, subscribable)
          unless subscribes?(subscriber, subscribable)
            self.create! do |subscribe|
              subscribe.subscriber = subscriber
              subscribe.subscribable = subscribable
            end
            #call_after_create_hooks(subscriber, subscribable)
            true
          else
            false
          end
        end

        def self.unsubscribe!(subscriber, subscribable)
          if subscribes?(subscriber, subscribable)
            subscribe_for(subscriber, subscribable).destroy_all
            #call_after_destroy_hooks(subscriber, subscribable)
            true
          else
            false
          end
        end

        def self.subscribes?(subscriber, subscribable)
          !subscribe_for(subscriber, subscribable).empty?
        end

        # Returns an ActiveRecord::Relation of all the followers of a certain type that are following subscribale
        def self.subscribers_relation(subscribable, klass, opts = {})
          rel = klass.where(:id =>
            self.select(:subscriber_id).
              where(:subscriber_type => klass.table_name.classify).
              where(:subscribable_type => subscribable.class.to_s).
              where(:subscribable_id => subscribable.id)
          )

          if opts[:pluck]
            rel.pluck(opts[:pluck])
          else
            rel
          end
        end

        # Returns all the followers of a certain type that are following subscribale
        def self.subscribers(subscribable, klass, opts = {})
          rel = subscribers_relation(subscribable, klass, opts)
          if rel.is_a?(ActiveRecord::Relation)
            rel.to_a
          else
            rel
          end
        end

        # Returns an ActiveRecord::Relation of all the followables of a certain type that are followed by subscriber
        def self.subscribables_relation(subscriber, klass, opts = {})
          rel = klass.where(:id =>
            self.select(:subscribable_id).
              where(:subscribable_type => klass.table_name.classify).
              where(:subscriber_type => subscriber.class.to_s).
              where(:subscriber_id => subscriber.id)
          )

          if opts[:pluck]
            rel.pluck(opts[:pluck])
          else
            rel
          end
        end

        # Returns all the followables of a certain type that are followed by subscriber
        def self.subscribables(subscriber, klass, opts = {})
          rel = subscribables_relation(subscriber, klass, opts)
          if rel.is_a?(ActiveRecord::Relation)
            rel.to_a
          else
            rel
          end
        end

        # Remove all the followers for subscribale
        def self.remove_subscribers(subscribable)
          self.where(:subscribable_type => subscribable.class.name.classify).
               where(:subscribable_id => subscribable.id).destroy_all
        end

        # Remove all the followables for subscriber
        def self.remove_subscribables(subscriber)
          self.where(:subscriber_type => subscriber.class.name.classify).
               where(:subscriber_id => subscriber.id).destroy_all
        end

      private
        def self.subscribe_for(subscriber, subscribable)
          subscribed_by(subscriber).subscribing(subscribable)
        end       
end
