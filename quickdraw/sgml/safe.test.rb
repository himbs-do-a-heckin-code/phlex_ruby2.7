# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

class SafeTest < Minitest::Test
	def test_safe_attribute_values
		output = phlex do
			a(
				onclick: safe("window.history.back()"),
				href: safe("javascript:window.history.back()"),
			)
		end

		assert_equal output, %(<a onclick="window.history.back()" href="javascript:window.history.back()"></a>)
	end

	def test_element_content_blocks_that_return_safe_values
		output = phlex do
			script {
				safe(%(console.log("Hello World");))
			}
		end

		assert_equal output, %(<script>console.log("Hello World");</script>)
	end

	def test_with_invalid_input
		error = assert_raises(Phlex::ArgumentError) do
			phlex { script { safe(123) } }
		end

		assert_equal error.message, "Expected a String."
	end
end
