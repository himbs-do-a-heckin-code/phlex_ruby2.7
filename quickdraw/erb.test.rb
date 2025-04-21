# frozen_string_literal: true

require "minitest/autorun"
require "phlex"

class ERBTest < Minitest::Test
	class Example < Phlex::HTML
		def initialize
			@text = "text"
			@html = safe "<div>html</div>"
		end

		erb :view_template, <<~ERB
			<% card do %>
				<h1><%= @text %></h1>
				<%= @html %>
				<%= phlex_snippet %>
			<% end %>
		ERB

		erb :erb_snippet, <<~ERB, locals: %(text:)
			<h2>Goodbye <%= text %></h2>
		ERB

		def phlex_snippet
			p { "How do you do?" }
		end

		def card
			section do
				article do
					yield
				end
				erb_snippet(text: "Joel")
			end
		end
	end

	def test_erb_rendering
		output = Example.call

		assert_equal_html <<~HTML.strip, output
			<section>
				<article>
					<h1>text</h1>
					<div>html</div>
					<p>How do you do?</p>
				</article>
				<h2>Goodbye Joel</h2>
			</section>
		HTML
	end

	private

	def assert_equal_html(expected, actual)
		assert_equal expected.gsub(/\s+/, ""), actual.gsub(/\s+/, "")
	end
end
