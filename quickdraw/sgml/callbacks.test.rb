# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
require_relative "../../fixtures/sgml_helper"
include SGMLHelper

class Example < Phlex::HTML
	def before_template
		i { "1" }
	end

	def around_template
		i { "2" }

		super do
			i { "3" }
			yield
			i { "5" }
		end

		i { "6" }
	end

	def after_template
		i { "7" }
	end

	def view_template
		i { "4" }
	end
end

class CallbacksTest < Minitest::Test
	def test_callbacks_are_called_in_the_correct_order
		assert_equal Example.call, "<i>1</i><i>2</i><i>3</i><i>4</i><i>5</i><i>6</i><i>7</i>"
	end
end
