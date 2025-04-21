# frozen_string_literal: true

require "minitest/autorun"
require "phlex"

module SvgHelper
	class Example < Phlex::HTML
		def view_template
			svg do |s|
				s.path(d: "321")
			end
		end
	end

	class ExampleWithoutContent < Phlex::HTML
		def view_template
			svg
		end
	end
end



class SvgTest < Minitest::Test
	def test_rendering_svg_without_content
		assert_equal %(<svg></svg>), SvgHelper::ExampleWithoutContent.call
	end

	def test_rendering_svg_inside_html_components
		assert_equal %(<svg><path d="321"></path></svg>), SvgHelper::Example.call
	end
end
