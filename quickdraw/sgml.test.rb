# frozen_string_literal: true

require "minitest/autorun"
require "phlex"

class SGMLTest < Minitest::Test
	def test_components_render_with_a_default_blank_view_template
		component = Class.new(Phlex::HTML) do
			def view_template
			end
		end

		assert_equal component.new.call, ""
	end

	def test_components_with_old_template_method_render_warning
		component = Class.new(Phlex::HTML) do
			def template
				span "old template"
			end
		end

		assert_equal component.new.call, Phlex::Escape.html_escape(
			%(Phlex Warning: Your `#{component.name}` class doesn't define a `view_template` method. If you are upgrading to Phlex 2.x make sure to rename your `template` method to `view_template`. See: https://beta.phlex.fun/guides/v2-upgrade.html)
		)
	end

	def test_components_with_no_view_template_method_render_warning
		component = Class.new(Phlex::HTML)

		assert_equal component.new.call, Phlex::Escape.html_escape(
			%(Phlex Warning: Your `#{component.name}` class doesn't define a `view_template` method. If you are upgrading to Phlex 2.x make sure to rename your `template` method to `view_template`. See: https://beta.phlex.fun/guides/v2-upgrade.html)
		)
	end

	def test_cant_render_a_component_more_than_once
		component = Class.new(Phlex::HTML)

		instance = component.new
		instance.call

		assert_raises(Phlex::DoubleRenderError) { instance.call }
	end
end
