# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

class WhitespaceTest < Minitest::Test
	def test_whitespace_between
		output = phlex do
			div
			whitespace
			div
		end

		assert_equal output, %(<div></div> <div></div>)
	end

	def test_whitespace_around
		output = phlex do
			div
			whitespace { div }
			div
		end

		assert_equal output, %(<div></div> <div></div> <div></div>)
	end
end
