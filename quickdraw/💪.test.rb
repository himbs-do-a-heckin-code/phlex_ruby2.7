require "minitest/autorun"
require "phlex"

class EmojiTest < Minitest::Test
	class Example < 💪::HTML
		def view_template
			h1 { "💪" }
		end
	end

	def test_emoji_component
		assert_equal %(<h1>💪</h1>), Example.new.call
	end
end
