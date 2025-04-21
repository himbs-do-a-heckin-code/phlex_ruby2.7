# frozen_string_literal: true

require "minitest/autorun"
require "phlex"

class HTMLTest < Minitest::Test
	def test_content_type
		component = Class.new(Phlex::HTML)
		assert_equal "text/html", component.new.content_type
	end
end
