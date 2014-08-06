# this file serves as quick fixes for activeadmin-mongoid

# https://github.com/elia/activeadmin-mongoid/issues/79
module ActiveAdmin::Mongoid::Document
  module ClassMethods
    def primary_key
      :id
    end
  end
end

# https://github.com/elia/activeadmin-mongoid/issues/52
module ActiveAdmin
  module Filters
    module FormtasticAddons
      def klass
        @object.class
      end

      def polymorphic_foreign_type?(method)
        false
      end
    end
  end
end
