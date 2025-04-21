# frozen_string_literal: true

require "minitest/autorun"
require "phlex"

class ContextTest < Minitest::Test
	def test_user_context_passed_in_from_the_outside
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				h1 { context[:heading] }
			end
		end

		context = { heading: "Hello, World!" }
		assert_equal %(<h1>Hello, World!</h1>), example.new.call(context: context)
	end

	def test_user_context_passed_down
		a = Class.new(Phlex::HTML) do
			define_method :view_template do
				h1 { context[:heading] }
			end
		end

		b = Class.new(Phlex::HTML) do
			define_method :view_template do
				context[:heading] = "Hello, World!"
				render a.new
			end
		end

		assert_equal %(<h1>Hello, World!</h1>), b.new.call
	end

	def test_raises_argument_error_if_context_accessed_before_rendering
		component = Phlex::HTML.new

		error = assert_raises(Phlex::ArgumentError) { component.context }

		assert_equal <<~MESSAGE, error.message
			You can't access the context before the component has started rendering.
		MESSAGE
	end
end
