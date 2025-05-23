# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

class AttributesTest < Minitest::Test
	def test_id_attributes_must_be_lower_case_symbols
		assert_raises(Phlex::ArgumentError) { phlex { div("id" => "abc") } }
		assert_raises(Phlex::ArgumentError) { phlex { div("ID" => "abc") } }
		assert_raises(Phlex::ArgumentError) { phlex { div(:ID => "abc") } }

		output = phlex { div(id: "abc") }
		assert_equal output, %(<div id="abc"></div>)
	end

	def test_invalid_attribute_keys
		error = assert_raises(Phlex::ArgumentError) do
			phlex { div(Object.new => "abc") }
		end

		assert_equal error.message, "Attribute keys should be Strings or Symbols."
	end

	def test_unsafe_event_attribute
		error = assert_raises(Phlex::ArgumentError) do
			phlex { div("onclick" => true) }
		end

		assert_equal error.message, "Unsafe attribute name detected: onclick."
	end

	def test_href_with_hash
		error = assert_raises(Phlex::ArgumentError) do
			phlex { a(href: {}) }
		end

		assert_equal error.message, "Invalid attribute value for href: #{{}.inspect}."
	end

	def test_unsafe_href_attribute
		[
			phlex { a(href: "javascript:alert('hello')") },
			phlex { a(href: "Javascript:alert('hello')") },
			phlex { a("href" => "javascript:alert('hello')") },
			phlex { a("Href" => "javascript:alert('hello')") },
			phlex { a("Href" => "javascript:javascript:alert('hello')") },
			phlex { a(href: " \t\njavascript:alert('hello')") },
		].each do |output|
			assert_equal output, %(<a></a>)
		end
	end

	def test_unsafe_attribute_name_lt
		error = assert_raises(Phlex::ArgumentError) do
			phlex { div("<" => true) }
		end

		assert_equal error.message, "Unsafe attribute name detected: <."
	end

	def test_unsafe_attribute_name_gt
		error = assert_raises(Phlex::ArgumentError) do
			phlex { div(">" => true) }
		end

		assert_equal error.message, "Unsafe attribute name detected: >."
	end

	def test_unsafe_attribute_name_ampersand
		error = assert_raises(Phlex::ArgumentError) do
			phlex { div("&" => true) }
		end

		assert_equal error.message, "Unsafe attribute name detected: &."
	end

	def test_unsafe_attribute_name_single_quote
		error = assert_raises(Phlex::ArgumentError) do
			phlex { div("'" => true) }
		end

		assert_equal error.message, "Unsafe attribute name detected: '."
	end

	def test_unsafe_attribute_name_double_quote
		error = assert_raises(Phlex::ArgumentError) do
			phlex { div('"' => true) }
		end

		assert_equal error.message, "Unsafe attribute name detected: \"."
	end

	def test_attribute_nil
		output = phlex { div(attribute: nil) }
		assert_equal output, %(<div></div>)
	end

	def test_attribute_true
		output = phlex { div(attribute: true) }
		assert_equal output, %(<div attribute></div>)
	end

	def test_attribute_false
		output = phlex { div(attribute: false) }
		assert_equal output, %(<div></div>)
	end

	def test_attribute_string
		with_empty_string = phlex { div(attribute: "") }
		assert_equal with_empty_string, %(<div attribute=""></div>)

		with_regular_string = phlex { div(attribute: "test") }
		assert_equal with_regular_string, %(<div attribute="test"></div>)

		with_underscores = phlex { div(attribute: "with_underscores") }
		assert_equal with_underscores, %(<div attribute="with_underscores"></div>)

		with_dashes = phlex { div(attribute: "with-dashes") }
		assert_equal with_dashes, %(<div attribute="with-dashes"></div>)

		with_spaces = phlex { div(attribute: "with spaces") }
		assert_equal with_spaces, %(<div attribute="with spaces"></div>)

		with_single_quotes = phlex { div(attribute: "with 'single quotes'") }
		assert_equal with_single_quotes, %(<div attribute="with 'single quotes'"></div>)

		with_html = phlex { div(attribute: "with <html>") }
		assert_equal with_html, %(<div attribute="with <html>"></div>)

		with_double_quotes = phlex { div(attribute: 'with "double quotes"') }
		assert_equal with_double_quotes, %(<div attribute="with &quot;double quotes&quot;"></div>)
	end

	def test_attribute_symbol
		empty_symbol = phlex { div(attribute: :"") }
		assert_equal empty_symbol, %(<div attribute=""></div>)

		simple_symbol = phlex { div(attribute: :test) }
		assert_equal simple_symbol, %(<div attribute="test"></div>)

		symbol_with_underscores = phlex { div(attribute: :with_underscores) }
		assert_equal symbol_with_underscores, %(<div attribute="with-underscores"></div>)

		symbol_with_dashes = phlex { div(attribute: :"with-dashes") }
		assert_equal symbol_with_dashes, %(<div attribute="with-dashes"></div>)

		symbol_with_spaces = phlex { div(attribute: :"with spaces") }
		assert_equal symbol_with_spaces, %(<div attribute="with spaces"></div>)

		symbol_with_single_quotes = phlex { div(attribute: :"with 'single quotes'") }
		assert_equal symbol_with_single_quotes, %(<div attribute="with 'single quotes'"></div>)

		symbol_with_html = phlex { div(attribute: :"with <html>") }
		assert_equal symbol_with_html, %(<div attribute="with <html>"></div>)

		symbol_with_double_quotes = phlex { div(attribute: :'with "double quotes"') }
		assert_equal symbol_with_double_quotes, %(<div attribute="with &quot;double quotes&quot;"></div>)
	end

	def test_attribute_integer
		output = phlex { div(attribute: 0) }
		assert_equal output, %(<div attribute="0"></div>)

		output = phlex { div(attribute: 42) }
		assert_equal output, %(<div attribute="42"></div>)
	end

	def test_attribute_float
		output = phlex { div(attribute: 0.0) }
		assert_equal output, %(<div attribute="0.0"></div>)

		output = phlex { div(attribute: 42.0) }
		assert_equal output, %(<div attribute="42.0"></div>)

		output = phlex { div(attribute: 1.234) }
		assert_equal output, %(<div attribute="1.234"></div>)
	end

	def test_invalid_attribute_value
		assert_raises(Phlex::ArgumentError) do
			phlex { div(attribute: Object.new) }
		end
	end

	def test_attribute_array
		output = phlex { div(attribute: []) }
		assert_equal output, %(<div attribute=""></div>)
	end

	def test_attribute_array_nil
		output = phlex { div(attribute: [nil, nil, nil]) }
		assert_equal output, %(<div attribute=""></div>)
	end

	def test_attribute_array_string
		output = phlex { div(attribute: ["Hello", "World"]) }
		assert_equal output, %(<div attribute="Hello World"></div>)

		output = phlex { div(attribute: ["with_underscores", "with-dashes", "with spaces"]) }
		assert_equal output, %(<div attribute="with_underscores with-dashes with spaces"></div>)

		output = phlex { div(attribute: ["with 'single quotes'", 'with "double quotes"']) }
		assert_equal output, %(<div attribute="with 'single quotes' with &quot;double quotes&quot;"></div>)
	end

	def test_attribute_array_symbol
		output = phlex { div(attribute: [:hello, :world]) }
		assert_equal output, %(<div attribute="hello world"></div>)

		output = phlex { div(attribute: [:with_underscores, :"with-dashes", :"with spaces"]) }
		assert_equal output, %(<div attribute="with-underscores with-dashes with spaces"></div>)

		output = phlex { div(attribute: [:with, :"'single quotes'", :'"double quotes"']) }
		assert_equal output, %(<div attribute="with 'single quotes' &quot;double quotes&quot;"></div>)
	end

	def test_attribute_array_integer
		output = phlex { div(attribute: [0, 42]) }
		assert_equal output, %(<div attribute="0 42"></div>)
	end

	def test_attribute_array_float
		output = phlex { div(attribute: [0.0, 42.0, 1.234]) }
		assert_equal output, %(<div attribute="0.0 42.0 1.234"></div>)
	end

	def test_attribute_array_safe_object
		output = phlex { div(attribute: [Phlex::SGML::SafeValue.new("Hello")]) }
		assert_equal output, %(<div attribute="Hello"></div>)
	end

	def test_attribute_array_string_or_array
		output = phlex { div(attribute: ["hello", ["world"]]) }
		assert_equal output, %(<div attribute="hello world"></div>)
	end

	def test_attribute_array_array_or_string
		output = phlex { div(attribute: [["hello"], "world"]) }
		assert_equal output, %(<div attribute="hello world"></div>)
	end

	def test_attribute_array_string_or_empty_array
		output = phlex { div(attribute: ["hello", []]) }
		assert_equal output, %(<div attribute="hello"></div>)
	end

	def test_invalid_attribute_array
		assert_raises(Phlex::ArgumentError) do
			phlex { div(attribute: [Object.new]) }
		end
	end

	def test_attribute_hash_symbol_string
		output = phlex { div(attribute: { a_b_c: "world" }) }
		assert_equal output, %(<div attribute-a-b-c="world"></div>)

		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { :'"' => "a" }) } }
		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { :"'" => "a" }) } }
		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { :"&" => "a" }) } }
		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { :"<" => "a" }) } }
		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { :">" => "a" }) } }
	end

	def test_attribute_hash_string_string
		output = phlex { div(attribute: { "a_b_c" => "world" }) }
		assert_equal output, %(<div attribute-a_b_c="world"></div>)

		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { '"' => "a" }) } }
		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { "'" => "a" }) } }
		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { "&" => "a" }) } }
		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { "<" => "a" }) } }
		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { ">" => "a" }) } }
	end

	def test_attribute_hash_underscore_string
		by_itself = phlex { div(attribute: { _: "world" }) }
		assert_equal by_itself, %(<div attribute="world"></div>)

		with_others = phlex { div(data: { _: "test", controller: "hello" }) }
		assert_equal with_others, %(<div data="test" data-controller="hello"></div>)
	end

	def test_invalid_attribute_hash
		assert_raises(Phlex::ArgumentError) { phlex { div(attribute: { Object.new => "a" }) } }
	end

	def test_attribute_hash_string_string
		with_underscores = phlex { div(data: { controller: "with_underscores" }) }
		assert_equal with_underscores, %(<div data-controller="with_underscores"></div>)

		with_dashes = phlex { div(data: { controller: "with-dashes" }) }
		assert_equal with_dashes, %(<div data-controller="with-dashes"></div>)

		with_spaces = phlex { div(data: { controller: "with spaces" }) }
		assert_equal with_spaces, %(<div data-controller="with spaces"></div>)

		with_single_quotes = phlex { div(data: { controller: "with 'single quotes'" }) }
		assert_equal with_single_quotes, %(<div data-controller="with 'single quotes'"></div>)

		with_html = phlex { div(data: { controller: "with <html>" }) }
		assert_equal with_html, %(<div data-controller="with <html>"></div>)

		with_double_quotes = phlex { div(data: { controller: 'with "double quotes"' }) }
		assert_equal with_double_quotes, %(<div data-controller="with &quot;double quotes&quot;"></div>)
	end

	def test_attribute_hash_symbol_symbol
		output = phlex { div(data: { controller: :with_underscores }) }
		assert_equal output, %(<div data-controller="with-underscores"></div>)

		output = phlex { div(data: { controller: :"with-dashes" }) }
		assert_equal output, %(<div data-controller="with-dashes"></div>)

		output = phlex { div(data: { controller: :"with spaces" }) }
		assert_equal output, %(<div data-controller="with spaces"></div>)

		output = phlex { div(data: { controller: :"with 'single quotes'" }) }
		assert_equal output, %(<div data-controller="with 'single quotes'"></div>)

		output = phlex { div(data: { controller: :"with <html>" }) }
		assert_equal output, %(<div data-controller="with <html>"></div>)

		output = phlex { div(data: { controller: :'with "double quotes"' }) }
		assert_equal output, %(<div data-controller="with &quot;double quotes&quot;"></div>)
	end

	def test_attribute_hash_symbol_integer
		output = phlex { div(data: { controller: 42 }) }
		assert_equal output, %(<div data-controller="42"></div>)

		output = phlex { div(data: { controller: 1_234 }) }
		assert_equal output, %(<div data-controller="1234"></div>)

		output = phlex { div(data: { controller: 0 }) }
		assert_equal output, %(<div data-controller="0"></div>)
	end

	def test_attribute_hash_symbol_float
		output = phlex { div(data: { controller: 42.0 }) }
		assert_equal output, %(<div data-controller="42.0"></div>)

		output = phlex { div(data: { controller: 1.234 }) }
		assert_equal output, %(<div data-controller="1.234"></div>)

		output = phlex { div(data: { controller: 0.0 }) }
		assert_equal output, %(<div data-controller="0.0"></div>)
	end

	def test_attribute_hash_symbol_array
		output = phlex { div(data: { controller: [1, 2, 3] }) }
		assert_equal output, %(<div data-controller="1 2 3"></div>)
	end

	def test_attribute_hash_symbol_set
		output = phlex { div(data: { controller: Set[1, 2, 3] }) }
		assert_equal output, %(<div data-controller="1 2 3"></div>)
	end

	def test_attribute_hash_symbol_hash
		output = phlex { div(data: { controller: { hello: "world" } }) }
		assert_equal output, %(<div data-controller-hello="world"></div>)
	end

	def test_attribute_hash_symbol_safe_object
		output = phlex { div(data: { controller: Phlex::SGML::SafeValue.new("Hello") }) }
		assert_equal output, %(<div data-controller="Hello"></div>)
	end

	def test_attribute_hash_symbol_false
		output = phlex { div(data: { controller: false }) }
		assert_equal output, %(<div></div>)
	end

	def test_attribute_hash_symbol_nil
		output = phlex { div(data: { controller: nil }) }
		assert_equal output, %(<div></div>)
	end

	def test_invalid_attribute_hash
		assert_raises(Phlex::ArgumentError) do
			phlex { div(data: { controller: Object.new }) }
		end
	end

	def test_attribute_set_nil
		output = phlex { div(attribute: Set[nil, nil, nil]) }
		assert_equal output, %(<div attribute=""></div>)
	end

	def test_attribute_set_string
		output = phlex { div(attribute: Set["Hello", "World"]) }
		assert_equal output, %(<div attribute="Hello World"></div>)

		output = phlex { div(attribute: Set["with_underscores", "with-dashes", "with spaces"]) }
		assert_equal output, %(<div attribute="with_underscores with-dashes with spaces"></div>)

		output = phlex { div(attribute: Set["with 'single quotes'", 'with "double quotes"']) }
		assert_equal output, %(<div attribute="with 'single quotes' with &quot;double quotes&quot;"></div>)
	end

	def test_attribute_set_symbol
		output = phlex { div(attribute: Set[:hello, :world]) }
		assert_equal output, %(<div attribute="hello world"></div>)

		output = phlex { div(attribute: Set[:with_underscores, :"with-dashes", :"with spaces"]) }
		assert_equal output, %(<div attribute="with-underscores with-dashes with spaces"></div>)

		output = phlex { div(attribute: Set[:with, :"single quotes", :'"double quotes"']) }
		assert_equal output, %(<div attribute="with single quotes &quot;double quotes&quot;"></div>)
	end

	def test_attribute_set_integer
		output = phlex { div(attribute: Set[0, 42]) }
		assert_equal output, %(<div attribute="0 42"></div>)
	end

	def test_attribute_set_float
		output = phlex { div(attribute: Set[0.0, 42.0, 1.234]) }
		assert_equal output, %(<div attribute="0.0 42.0 1.234"></div>)
	end

	def test_attribute_set_safe_object
		output = phlex do
			div(attribute: Set[Phlex::SGML::SafeValue.new("Hello")])
		end

		assert_equal output, %(<div attribute="Hello"></div>)
	end

	def test_invalid_attribute_set
		assert_raises(Phlex::ArgumentError) do
			phlex { div(attribute: Set[Object.new]) }
		end
	end

	def test_attribute_style_array_nil
		output = phlex { div(style: [nil, nil, nil]) }
		assert_equal output, %(<div style=""></div>)
	end

	def test_attribute_style_array_symbol
		assert_raises(Phlex::ArgumentError) do
			phlex { div(style: [:color_blue]) }
		end
	end

	def test_attribute_style_array_string
		output = phlex { div(style: ["color: blue;", "font-weight: bold"]) }
		assert_equal output, %(<div style="color: blue; font-weight: bold;"></div>)

		output = phlex { div(style: ["font-family: 'MonoLisa'"]) }
		assert_equal output, %(<div style="font-family: 'MonoLisa';"></div>)

		output = phlex { div(style: ['font-family: "MonoLisa"']) }
		assert_equal output, %(<div style="font-family: &quot;MonoLisa&quot;;"></div>)
	end

	def test_attribute_style_array_safe_object
		output = phlex { div(style: [Phlex::SGML::SafeValue.new("color: blue")]) }
		assert_equal output, %(<div style="color: blue;"></div>)

		output = phlex { div(style: [Phlex::SGML::SafeValue.new("font-weight: bold;")]) }
		assert_equal output, %(<div style="font-weight: bold;"></div>)
	end

	def test_attribute_style_array_hash
		output = phlex { div(style: [{ color: "blue" }, { font_weight: "bold", line_height: 1.5 }]) }
		assert_equal output, %(<div style="color: blue; font-weight: bold; line-height: 1.5;"></div>)
	end

	def test_attribute_style_set_nil
		output = phlex { div(style: Set[nil]) }
		assert_equal output, %(<div style=""></div>)
	end

	def test_attribute_style_set_string
		output = phlex { div(style: Set["color: blue"]) }
		assert_equal output, %(<div style="color: blue;"></div>)
	end

	def test_attribute_style_hash_symbol_string
		output = phlex { div(style: { color: "blue", font_weight: "bold" }) }
		assert_equal output, %(<div style="color: blue; font-weight: bold;"></div>)
	end

	def test_attribute_style_hash_symbol_integer
		output = phlex { div(style: { line_height: 2 }) }
		assert_equal output, %(<div style="line-height: 2;"></div>)
	end

	def test_attribute_style_hash_symbol_float
		output = phlex { div(style: { line_height: 1.5 }) }
		assert_equal output, %(<div style="line-height: 1.5;"></div>)
	end

	def test_attribute_style_hash_symbol_symbol
		output = phlex { div(style: { flex_direction: :column_reverse }) }
		assert_equal output, %(<div style="flex-direction: column-reverse;"></div>)

		output = phlex { div(style: { flex_direction: :'"double quotes"' }) }
		assert_equal output, %(<div style="flex-direction: &quot;double quotes&quot;;"></div>)
	end

	def test_attribute_style_hash_symbol_safe_object
		output = phlex { div(style: { color: Phlex::SGML::SafeValue.new("blue") }) }
		assert_equal output, %(<div style="color: blue;"></div>)
	end

	def test_attribute_style_hash_symbol_nil
		output = phlex { div(style: { color: nil }) }
		assert_equal output, %(<div style=""></div>)
	end

	def test_invalid_attribute_style_hash
		assert_raises(Phlex::ArgumentError) do
			phlex { div(style: { color: Object.new }) }
		end
	end

	def test_attribute_style_hash_string_string
		output = phlex { div(style: { "color" => "blue" }) }
		assert_equal output, %(<div style="color: blue;"></div>)
	end

	def test_invalid_attribute_style_hash
		assert_raises(Phlex::ArgumentError) do
			phlex { div(style: { Object.new => "blue" }) }
		end
	end

	# This is just for coverage.
	Phlex::HTML.call do |c|
		c.__send__(:__styles__, nil)
	end
end
