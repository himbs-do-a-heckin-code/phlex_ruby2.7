# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../fixtures/components"
require_relative "../fixtures/sgml_helper"
include SGMLHelper

class KitExample < Phlex::HTML
	include Components

	def view_template
		SayHi("Joel", times: 2) { "Inside" }
		Components::SayHi("Will", times: 1) { "Inside" }
	end
end

class KitTest < Minitest::Test
	def test_raises_when_you_try_to_render_a_component_outside_of_a_rendering_context
		error = assert_raises(RuntimeError) { Components::SayHi("Joel") }
		assert_equal error.message, "You can't call `SayHi' outside of a Phlex rendering context."
	end

	def test_defines_methods_for_its_components
		assert_equal KitExample.new.call, %(<article><h1>Hi Joel</h1><h1>Hi Joel</h1>Inside</article><article><h1>Hi Will</h1>Inside</article>)
	end

	def test_nested_kits
		assert_equal phlex { Components::Foo::Bar() }, "<h1>Bar</h1>"
	end
end
