require "active_support"
require "active_support/core_ext"

module CamelAccessor
  module Define
    extend ActiveSupport::Concern

    included do
      class << self
        attr_accessor :camel_accessor_targets
      end
    end

    class_methods do
      def camel_accessor
        camel_accessor_to(*attribute_names)
      end

      def camel_accessor_to(*props)
        self.camel_accessor_targets ||= Set.new
        self.camel_accessor_targets += Set.new(props.flat_map { |x| to_camel(x) })
      end

      def to_camel(prop)
        # TODO: support lower camel
        camelized = prop.to_s.camelize
        [:"#{camelized}"]
      end

      def define_camel_accessor_method(method_name)
        define_method(method_name) { read_attribute(method_name.to_s.underscore) }
        define_method("#{method_name}=") { |value| write_attribute(method_name.to_s.underscore, value) }
      end
    end

    def respond_to_missing?(method_name, _include_private = false)
      self.class.camel_accessor_targets.include?(method_name) ? true : super
    end

    def method_missing(method_name, *args, &block)
      trimed = trim_assigner(method_name)
      if self.class.camel_accessor_targets.include?(trimed)
        self.class.define_camel_accessor_method(trimed)
        return send(method_name, *args, &block)
      end
      super
    end

    def trim_assigner(method_name)
      str = method_name.to_s
      str = str.chop if str.end_with?("=")
      str.to_sym
    end
  end
end

ActiveRecord::Base.include CamelAccessor::Define
