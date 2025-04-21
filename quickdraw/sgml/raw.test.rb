# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

class RawTest < Minitest::Test
	def test_with_an_unsafe_object
		error = assert_raises(Phlex::ArgumentError) do
			phlex { raw "<div></div>" }
		end

		assert_equal error.message, "You passed an unsafe object to `raw`."
	end

	def test_with_a_safe_object
		output = phlex { raw safe %(<div class="hello">&</div>) }
		assert_equal output, %(<div class="hello">&</div>)
	end

	def test_with_nil
		output = phlex { div { raw nil } }
		assert_equal output, "<div></div>"
	end

	def test_with_empty_string
		output = phlex { div { raw "" } }
		assert_equal output, "<div></div>"
	end
end
