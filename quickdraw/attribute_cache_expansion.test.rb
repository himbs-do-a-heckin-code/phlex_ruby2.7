# frozen_string_literal: true

require "minitest/autorun"
require "phlex"

module AssertHelper
	def self.assert_nothing_raised
		yield
	rescue => e
		flunk "Expected no exception to be raised, but got #{e.class}: #{e.message}"
	end
end

class AttributeCacheExpansionTest < Minitest::Test
	def test_using_component_without_source_location
		AssertHelper.assert_nothing_raised do
			# Intentionally not passing a source location here.
			eval <<~RUBY
				class Example < Phlex::HTML
					def view_template
					end
				end
			RUBY
		end
	end
end
