# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

module ToProcHelper
	class Example < Phlex::HTML
		def view_template(&block)
			article(&block)
		end
	
		def slot(&block)
			render(&block)
		end
	end
	
	class Sub < Phlex::HTML
		def view_template
			h1 { "Sub" }
		end
	end
end

class ToProcTest < Minitest::Test
	def test_rendering_components_via_to_proc
		output = phlex do
			render ToProcHelper::Example do |e|
				e.slot(&ToProcHelper::Sub.new)
			end
		end

		assert_equal output, %(<article><h1>Sub</h1></article>)
	end
end
