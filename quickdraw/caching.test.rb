require "minitest/autorun"
require "phlex"

class CachingTest < Minitest::Test
	CacheStore = Phlex::FIFOCacheStore.new

	class CacheTest < Phlex::HTML
		def cache_store
			CacheStore
		end

		def initialize(execution_watcher)
			@execution_watcher = execution_watcher
		end

		def view_template
			cache do
				@execution_watcher.call
				"OK"
			end
		end
	end

	def test_caching_a_block_only_executes_once
		run_count = 0
		monitor = -> { run_count += 1 }
		CacheTest.new(monitor).call
		assert_equal 1, run_count
		CacheTest.new(monitor).call
		assert_equal 1, run_count
	end
end
