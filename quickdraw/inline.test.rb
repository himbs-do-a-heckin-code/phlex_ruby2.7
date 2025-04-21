require "minitest/autorun"
require "phlex"

class InlineTest < Minitest::Test
	def title
		"Hello"
	end

	def test_inline_html_with_no_param
		output = Phlex.html do
			h1 { "Hi" }
		end

		assert_equal "<h1>Hi</h1>", output
	end

	def test_inline_html_with_yield_param
		@ivar = "Hi"
		h1 = "foo"

		output = Phlex.html do |receiver|
			h1 { h1 }
			h1 { @ivar }
			title { receiver.title }
		end

		assert_equal "<h1>foo</h1><h1>Hi</h1><title>Hello</title>", output
	end
end
