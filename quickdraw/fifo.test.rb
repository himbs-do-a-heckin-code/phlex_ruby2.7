require "minitest/autorun"
require "phlex"

class FIFOTest < Minitest::Test
	def test_expires_keys
		fifo = Phlex::FIFO.new(max_bytesize: 3)

		100.times do |i|
			fifo[i] = "a"
		end

		assert_equal 3, fifo.size
	end

	def test_reading_a_key
		fifo = Phlex::FIFO.new(max_bytesize: 3)

		fifo[0] = "a"

		assert_equal "a", fifo[0]
	end

	def test_ignores_values_that_are_too_large
		fifo = Phlex::FIFO.new(max_bytesize: 100, max_value_bytesize: 10)

		fifo[1] = "a" * 10
		fifo[2] = "a" * 11

		assert_equal 1, fifo.size
	end
end
