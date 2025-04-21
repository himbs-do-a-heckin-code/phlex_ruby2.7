# frozen_string_literal: true

module ConstantAddedShim
  def self.enable_for(mod)
    mod.instance_variable_set(:@__known_constants, mod.constants(false))

    trace = TracePoint.new(:line) do |_tp|
      current_constants = mod.constants(false)
      known_constants = mod.instance_variable_get(:@__known_constants)

      new_constants = current_constants - known_constants

      new_constants.each do |const_name|
        if mod.respond_to?(:const_added)
          mod.const_added(const_name)
        end
      end

      mod.instance_variable_set(:@__known_constants, current_constants)
    end

    mod.instance_variable_set(:@__const_added_trace, trace)
    trace.enable
  end

  def self.disable_for(mod)
    if (trace = mod.instance_variable_get(:@__const_added_trace))
      trace.disable
    end
  end
end

module Phlex::Kit
	module LazyLoader
		def method_missing(name, ...)
			mod = self.class

			if name[0] == name[0].upcase && mod.constants.include?(name) && con = mod.const_get(name) && methods.include?(name)
        public_send(name, ...)
			else
				super
			end
		end

		def respond_to_missing?(name, include_private = false)
			mod = self.class
			(name[0] == name[0].upcase && mod.constants.include?(name) && mod.const_get(name) && methods.include?(name)) || super
		end
	end

	def self.extended(mod)
		case mod
		when Class
			raise Phlex::ArgumentError.new(<<~MESSAGE)
				`Phlex::Kit` was extended into #{mod.name}.

				You should only extend modules with `Phlex::Kit` as it is not compatible with classes.
			MESSAGE
		else
			mod.include(LazyLoader)
      ConstantAddedShim.enable_for(mod)
		end
	end

	def method_missing(name, ...)
		if name[0] == name[0].upcase && constants.include?(name) && const_get(name) && methods.include?(name)
			public_send(name, ...)
		else
			super
		end
	end

	def respond_to_missing?(name, include_private = false)
		(name[0] == name[0].upcase && constants.include?(name) && const_get(name) && methods.include?(name)) || super
	end

	def const_added(name)
    
		me = self
		constant = const_get(name)
    
		case constant
		when Class
			if constant < Phlex::SGML
				constant.include(me)

			  define_method(name) do |*args, **kwargs, &block|
					const = me.const_get(name)
					render(const.new(*args, **kwargs), &block)
				end

				define_singleton_method(name) do |*args, **kwargs, &block|
					component, fiber_id = Thread.current[:__phlex_component__]
					if (component && fiber_id == Fiber.current.object_id)
						component.instance_exec do
							const = me.const_get(name)
							render(const.new(*args, **kwargs), &block)
						end
					else
						raise "You can't call `#{name}' outside of a Phlex rendering context."
					end
				end
			end
		when Module
			constant.extend(Phlex::Kit)
		end
    if defined?(super) && self.class.superclass.method_defined?(:const_added)
      super
    end
	end
end
