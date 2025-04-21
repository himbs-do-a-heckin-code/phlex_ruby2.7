# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
include Phlex::Helpers

class GrabTest < Minitest::Test
	def test_single_binding
		output = grab(class: "foo")
		assert_equal output, "foo"
	end

	def test_multiple_bindings
		output = grab(class: "foo", if: "bar")
		assert_equal output, ["foo", "bar"]
	end
end
