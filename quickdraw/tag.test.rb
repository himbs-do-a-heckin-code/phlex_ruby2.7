require "minitest/autorun"
require "phlex"

class TagTest < Minitest::Test
	class HTMLComponent < Phlex::HTML
		def initialize(tag, **attributes)
			@tag = tag
			@attributes = attributes
		end

		def view_template(&block)
			tag(@tag, **@attributes, &block)
		end
	end

	class SVGComponent < Phlex::SVG
		def initialize(tag, **attributes)
			@tag = tag
			@attributes = attributes
		end

		def view_template(&block)
			tag(@tag, **@attributes, &block)
		end
	end

	Phlex::HTML::VoidElements.__registered_elements__.each do |method_name, tag|
		define_method("test_#{tag}_html_tag_without_attributes") do
			output = HTMLComponent.call(tag.to_sym)

			assert_equal <<~HTML.strip, output
				<#{tag}>
			HTML
		end

		define_method("test_#{tag}_html_tag_with_attributes") do
			output = HTMLComponent.call(tag.to_sym, class: "class", id: "id", disabled: true)

			assert_equal <<~HTML.strip, output
				<#{tag} class="class" id="id" disabled>
			HTML
		end

		define_method("test_#{tag}_html_tag_with_content") do
			error = assert_raises(Phlex::ArgumentError) do
				HTMLComponent.call(tag.to_sym) do
					"Hello, world!"
				end
			end

			assert_equal "Void elements cannot have content blocks.", error.message
		end
	end

	Phlex::HTML::StandardElements.__registered_elements__.each do |method_name, tag|
		define_method("test_#{tag}_html_tag_without_attributes") do
			output = HTMLComponent.call(tag.to_sym)

			assert_equal <<~HTML.strip, output
				<#{tag}></#{tag}>
			HTML
		end

		define_method("test_#{tag}_html_tag_with_attributes") do
			output = HTMLComponent.call(tag.to_sym, class: "class", id: "id", disabled: true)

			assert_equal <<~HTML.strip, output
				<#{tag} class="class" id="id" disabled></#{tag}>
			HTML
		end

		define_method("test_#{tag}_html_tag_with_content") do
			output = HTMLComponent.call(tag.to_sym) do
				"Hello, world!"
			end

			assert_equal <<~HTML.strip, output
				<#{tag}>Hello, world!</#{tag}>
			HTML
		end

		define_method("test_#{tag}_html_tag_with_content_and_attributes") do
			output = HTMLComponent.call(tag.to_sym, class: "class", id: "id", disabled: true) do
				"Hello, world!"
			end

			assert_equal <<~HTML.strip, output
				<#{tag} class="class" id="id" disabled>Hello, world!</#{tag}>
			HTML
		end
	end

	Phlex::SVG::StandardElements.__registered_elements__.each do |method_name, tag|
		define_method("test_#{tag}_svg_tag_without_attributes") do
			output = SVGComponent.call(tag.to_sym)

			assert_equal <<~HTML.strip, output
				<#{tag}></#{tag}>
			HTML
		end

		define_method("test_#{tag}_svg_tag_with_attributes") do
			output = SVGComponent.call(tag.to_sym, class: "class", id: "id", disabled: true)

			assert_equal <<~HTML.strip, output
				<#{tag} class="class" id="id" disabled></#{tag}>
			HTML
		end

		define_method("test_#{tag}_svg_tag_with_content") do
			output = SVGComponent.call(tag.to_sym) do
				"Hello, world!"
			end

			assert_equal <<~HTML.strip, output
				<#{tag}>Hello, world!</#{tag}>
			HTML
		end

		define_method("test_#{tag}_svg_tag_with_content_and_attributes") do
			output = SVGComponent.call(tag.to_sym, class: "class", id: "id", disabled: true) do
				"Hello, world!"
			end

			assert_equal <<~HTML.strip, output
				<#{tag} class="class" id="id" disabled>Hello, world!</#{tag}>
			HTML
		end
	end

	def test_svg_tag_in_html
		output = HTMLComponent.call(:svg) do |svg|
			svg.circle(cx: 50, cy: 50, r: 40, fill: "red")
		end

		assert_equal <<~HTML.strip, output
			<svg><circle cx="50" cy="50" r="40" fill="red"></circle></svg>
		HTML
	end

	def test_with_invalid_tag_name
		error = assert_raises(Phlex::ArgumentError) do
			HTMLComponent.call(:invalidtag)
		end

		assert_equal "Invalid HTML tag: invalidtag", error.message
	end

	def test_with_invalid_tag_name_input_type
		error = assert_raises(Phlex::ArgumentError) do
			HTMLComponent.call("div")
		end

		assert_equal "Expected the tag name to be a Symbol.", error.message
	end

	def test_with_custom_tag_name
		output = HTMLComponent.call(:custom_tag)

		assert_equal <<~HTML.strip, output
			<custom-tag></custom-tag>
		HTML
	end
end
