# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

module ConditionalRenderingHelper
	class Example < Phlex::HTML
		def initialize(render:)
			@render = render
		end

		def render?; @render; end

		def view_template
			h1 { "Hello" }
		end
	end

	class ExampleWithContext < Phlex::HTML
		def render?; context[:render]; end

		def view_template
			h1 { "Hello" }
		end
	end
end

class ConditionalRenderingTest < Minitest::Test
	def test_conditional_rendering_with_initializer
		assert_equal ConditionalRenderingHelper::Example.new(render: true).call, "<h1>Hello</h1>"
		assert_equal ConditionalRenderingHelper::Example.new(render: false).call, ""
	end

	def test_conditional_rendering_with_context
		assert_equal ConditionalRenderingHelper::ExampleWithContext.new.call(context: { render: true }), "<h1>Hello</h1>"
		assert_equal ConditionalRenderingHelper::ExampleWithContext.new.call(context: { render: false }), ""
	end
end
