# frozen_string_literal: true

require "minitest/autorun"
require "phlex"

class ExampleComponent < Phlex::HTML
	def view_template(&block)
		div(&block)
	end
end

class StandardElementExample < Phlex::HTML
	def initialize(execution_checker = -> {})
		@execution_checker = execution_checker
	end

	def view_template
		doctype
		div {
			comment { h1(id: "target") }
			h1 { "Before" }
			img(src: "before.jpg")
			render ExampleComponent.new { "Should not render" }
			whitespace
			comment { "This is a comment" }
			fragment("target") do
				h1(id: "target") {
					plain "Hello"
					strong { "World" }
					img(src: "image.jpg")
				}
			end
			@execution_checker.call
			strong { "Here" }
			fragment("image") do
				img(id: "image", src: "after.jpg")
			end
			h1(id: "target") { "After" }
		}
	end
end

class VoidElementExample < Phlex::HTML
	def view_template
		doctype
		div {
			comment { h1(id: "target") }
			h1 { "Before" }
			img(src: "before.jpg")
			whitespace
			comment { "This is a comment" }
			h1 {
				plain "Hello"
				strong { "World" }
				fragment("target") do
					img(id: "target", src: "image.jpg")
				end
			}
			img(src: "after.jpg")
			h1(id: "target") { "After" }
		}
	end
end

class WithCaptureBlock < Phlex::HTML
	def view_template
		h1(id: "before") { "Before" }
		fragment("around") do
			div(id: "around") do
				capture do
					fragment("inside") do
						h1(id: "inside") { "Inside" }
					end
				end
			end
		end
		fragment("after") do
			h1(id: "after") { "After" }
		end
	end
end

class SelectiveRenderingTest < Minitest::Test
	def test_renders_the_just_the_target_fragment
		output = StandardElementExample.new.call(fragments: ["target"])
		assert_equal output, %(<h1 id="target">Hello<strong>World</strong><img src="image.jpg"></h1>)
	end

	def test_works_with_void_elements
		output = VoidElementExample.new.call(fragments: ["target"])
		assert_equal output, %(<img id="target" src="image.jpg">)
	end

	def test_supports_multiple_fragments
		output = StandardElementExample.new.call(fragments: ["target", "image"])
		assert_equal output, %(<h1 id="target">Hello<strong>World</strong><img src="image.jpg"></h1><img id="image" src="after.jpg">)
	end

	def test_halts_early_after_all_fragments_are_found
		called = false
		checker = -> { called = true }
		StandardElementExample.new(checker).call(fragments: ["target"])

		refute called
	end

	def test_with_a_capture_block_doesnt_render_the_capture_block
		output = WithCaptureBlock.new.call(fragments: ["after"])
		assert_equal output, %(<h1 id="after">After</h1>)
	end

	def test_with_a_capture_block_renders_the_capture_block_when_selected
		output = WithCaptureBlock.new.call(fragments: ["around"])
		assert_equal output, %(<div id="around">&lt;h1 id=&quot;inside&quot;&gt;Inside&lt;/h1&gt;</div>)
	end

	def test_with_a_capture_block_doesnt_select_from_the_capture_block
		output = WithCaptureBlock.new.call(fragments: ["inside"])
		assert_equal output, ""
	end
end
