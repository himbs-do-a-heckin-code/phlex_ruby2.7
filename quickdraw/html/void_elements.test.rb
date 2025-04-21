# frozen_string_literal: true

require "minitest/autorun"
require "phlex"

class VoidElementsTest < Minitest::Test
	Phlex::HTML::VoidElements.__registered_elements__.each do |method_name, tag|
		define_method "test_#{tag}_with_attributes" do
			example = Class.new(Phlex::HTML) do
				define_method :view_template do
					__send__(method_name, class: "class", id: "id", disabled: true, selected: false)
				end
			end

			assert_equal(example.call, %(<#{tag} class="class" id="id" disabled>))
		end

		define_method "test_#{tag}_with_string_attribute_keys" do
			example = Class.new(Phlex::HTML) do
				define_method :view_template do
					__send__(method_name, "attribute_with_underscore" => true)
				end
			end

			assert_equal(example.call, %(<#{tag} attribute_with_underscore>))
		end

		define_method "test_#{tag}_with_hash_attribute_values" do
			example = Class.new(Phlex::HTML) do
				define_method :view_template do
					__send__(method_name, aria: { hidden: true }, data_turbo: { frame: "_top" })
				end
			end

			assert_equal(example.call, %(<#{tag} aria-hidden data-turbo-frame="_top">))
		end
	end
end
