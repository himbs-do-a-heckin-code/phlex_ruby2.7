require "minitest/autorun"
require "phlex"

class FIFOCacheStoreTest < Minitest::Test
	def test_fetch_caches_the_yield
		store = Phlex::FIFOCacheStore.new
		count = 0

		first_read = store.fetch("a") do
			count += 1
			"A"
		end

		assert_equal "A", first_read
		assert_equal 1, count

		second_read = store.fetch("a") do
			flunk "This block should not have been called."
			"B"
		end

		assert_equal "A", second_read
		assert_equal 1, count
	end

	def test_nested_caches_do_not_lead_to_contention
		store = Phlex::FIFOCacheStore.new

		result = store.fetch("a") do
			[
				"A",
				store.fetch("b") { "B" },
			].join(", ")
		end

		assert_equal "A, B", result
	end
end
