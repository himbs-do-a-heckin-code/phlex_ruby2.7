# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

class PlainTest < Minitest::Test
	def test_with_string
		output = phlex { plain "Hello, World!" }
		assert_equal output, "Hello, World!"
	end

	def test_with_symbol
		output = phlex { plain :hello_world }
		assert_equal output, "hello_world"
	end

	def test_with_integer
		output = phlex { plain 42 }
		assert_equal output, "42"
	end

	def test_with_float
		output = phlex { plain 3.14 }
		assert_equal output, "3.14"
	end

	def test_with_nil
		output = phlex { plain nil }
		assert_equal output, ""
	end

	def test_with_invalid_arguments
		assert_raises(Phlex::ArgumentError) do
			phlex { plain [] }
		end
	end
end
