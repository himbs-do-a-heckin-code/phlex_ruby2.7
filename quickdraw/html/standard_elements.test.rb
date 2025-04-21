# frozen_string_literal: true

require "minitest/autorun"
require "phlex"

class StandardElementsTest < Minitest::Test
	Phlex::HTML::StandardElements.__registered_elements__.each do |method_name, tag|
		define_method "test_#{tag}_with_block_content_and_attributes" do
			example = Class.new(Phlex::HTML) do
				define_method :view_template do
					__send__(method_name, class: "class", id: "id", disabled: true, selected: false) { h1 { "Hello" } }
				end
			end

			assert_equal example.call, %(<#{tag} class="class" id="id" disabled><h1>Hello</h1></#{tag}>)
		end

		define_method "test_#{tag}_with_block_text_content_and_attributes" do
			example = Class.new(Phlex::HTML) do
				define_method :view_template do
					__send__(method_name, class: "class", id: "id", disabled: true, selected: false) { "content" }
				end
			end

			assert_equal example.call, %(<#{tag} class="class" id="id" disabled>content</#{tag}>)
		end

		define_method "test_#{tag}_with_string_attribute_keys" do
			example = Class.new(Phlex::HTML) do
				define_method :view_template do
					__send__(method_name, "attribute_with_underscore" => true) { "content" }
				end
			end

			assert_equal example.call, %(<#{tag} attribute_with_underscore>content</#{tag}>)
		end

		define_method "test_#{tag}_with_hash_attribute_values" do
			example = Class.new(Phlex::HTML) do
				define_method :view_template do
					__send__(method_name, aria: { hidden: true }, data_turbo: { frame: "_top" }) { "content" }
				end
			end

			assert_equal example.call, %(<#{tag} aria-hidden data-turbo-frame="_top">content</#{tag}>)
		end
	end
end
