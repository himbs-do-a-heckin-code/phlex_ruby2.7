require "minitest/autorun"
require "phlex"

class SVGTest < Minitest::Test
	class Example < Phlex::SVG
		def view_template
			svg do
				path(d: "123")
			end
		end
	end

	def test_basic_svg
		assert_equal %(<svg><path d="123"></path></svg>), Example.call
	end

	def test_content_type
		component = Class.new(Phlex::SVG)
		assert_equal "image/svg+xml", component.new.content_type
	end

	def test_cdata_with_string
		component = Class.new(Phlex::SVG) do
			def view_template
				cdata("Hello, <[[test]]> World!")
			end
		end

		assert_equal %(<![CDATA[Hello, <[[test]]>]]<![CDATA[ World!]]>), component.call
	end

	def test_cdata_with_block
		component = Class.new(Phlex::SVG) do
			def view_template
				cdata do
					path(d: "123")
				end
			end
		end

		assert_equal %(<![CDATA[<path d="123"></path>]]>), component.call
	end
end
