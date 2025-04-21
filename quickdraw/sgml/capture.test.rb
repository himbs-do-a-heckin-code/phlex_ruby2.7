# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

class ExampleCaptureWithArguments < Phlex::HTML
	def view_template(&block)
		h1 { capture("a", "b", "c", &block) }
	end
end

class CaptureTest < Minitest::Test
	def test_arguments_are_passed_to_the_capture_block
		output = ExampleCaptureWithArguments.new.call do |a, b, c|
			"#{a} #{b} #{c}"
		end

		assert_equal output, "<h1>a b c</h1>"
	end
end
