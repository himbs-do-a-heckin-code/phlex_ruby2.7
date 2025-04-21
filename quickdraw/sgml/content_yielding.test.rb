# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

class TestClass < Phlex::HTML
	def view_template
		select(name: "test") do
			[].each { |i| option_tag(i, i) }
		end

		input(type: "text", name: "other")
	end
end

class OtherTestClass < Phlex::HTML
	def view_template
		ul do
			[].each { |i| li { i } }
		end

		p { "hi there" }
	end
end

class ContentYieldingTest < Minitest::Test
	def test_rendering_test_class
		assert_equal TestClass.call, %q(<select name="test"></select><input type="text" name="other">)
	end

	def test_rendering_other_test_class
		assert_equal OtherTestClass.call, %q(<ul></ul><p>hi there</p>)
	end
end
