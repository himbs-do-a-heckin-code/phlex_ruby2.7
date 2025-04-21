# frozen_string_literal: true

module SGMLHelper
	def phlex(component = Phlex::HTML, *a, **k, &block)
		component.new(*a, **k).call do |e|
			e.instance_exec(&block)
		end
	end
end
