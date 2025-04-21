# frozen_string_literal: true

require "minitest/autorun"
require "phlex"

class DocTypeExample < Phlex::HTML
	def view_template
		html {
			head {
				doctype
			}
		}
	end
end

class DoctypeTest < Minitest::Test
	def test_doctype_rendering
		assert_equal DocTypeExample.call, "<html><head><!doctype html></head></html>"
	end
end
