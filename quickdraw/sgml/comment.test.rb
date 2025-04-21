# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

class CommentTest < Minitest::Test
	def test_text_comment
		output = phlex do
			comment { "Hello World" }
		end

		assert_equal output, "<!-- Hello World -->"
	end

	def test_block_comment_with_markup
		output = phlex do
			comment do
				h1 { "Hello World" }
			end
		end

		assert_equal output, "<!-- <h1>Hello World</h1> -->"
	end
end
