require "minitest/autorun"
require "phlex"

class SelectiveRenderingFromCacheTest < Minitest::Test
	class CacheTest < Phlex::HTML
		attr_reader :cache_store

		def initialize(page_id, cache_store: nil)
			@page_id = page_id
			@cache_store = cache_store
		end

		def view_template
			cache(@page_id) do
				h1 { "Page #{@page_id}" }
				fragment("outer") do
					div(id: "page") do
						cache do
							section do
								fragment("list") do
									ul do
										fragment("foo") { li { 1 } }
										li { 2 }
										li { 3 }
									end
								end
							end
						end
					end
				end
			end
		end
	end

	def test_rendering_component_with_caches_and_fragments_same_page
		cache_store = Phlex::FIFOCacheStore.new
		output = CacheTest.new(1, cache_store: cache_store).call
		assert_equal "<h1>Page 1</h1><div id=\"page\"><section><ul><li>1</li><li>2</li><li>3</li></ul></section></div>", output

		output = CacheTest.new(1, cache_store: cache_store).call
		assert_equal "<h1>Page 1</h1><div id=\"page\"><section><ul><li>1</li><li>2</li><li>3</li></ul></section></div>", output
	end

	def test_rendering_component_with_caches_and_fragments_different_pages
		cache_store = Phlex::FIFOCacheStore.new
		output = CacheTest.new(1, cache_store: cache_store).call
		assert_equal "<h1>Page 1</h1><div id=\"page\"><section><ul><li>1</li><li>2</li><li>3</li></ul></section></div>", output

		output = CacheTest.new(2, cache_store: cache_store).call
		assert_equal "<h1>Page 2</h1><div id=\"page\"><section><ul><li>1</li><li>2</li><li>3</li></ul></section></div>", output
	end

	def test_rendering_specific_fragment_from_within_cache
		cache_store = Phlex::FIFOCacheStore.new
		2.times do
			output = CacheTest.new(2, cache_store: cache_store).call(fragments: ["list"])
			assert_equal "<ul><li>1</li><li>2</li><li>3</li></ul>", output
		end
	end

	def test_rendering_nested_fragment_from_within_cache
		cache_store = Phlex::FIFOCacheStore.new
		output = CacheTest.new(1, cache_store: cache_store).call(fragments: ["foo"])
		assert_equal "<li>1</li>", output
	end

	def test_rendering_multiple_fragments_from_within_cache
		cache_store = Phlex::FIFOCacheStore.new
		output = CacheTest.new(1, cache_store: cache_store).call(fragments: ["list", "foo"])
		assert_equal "<ul><li>1</li><li>2</li><li>3</li></ul>", output
	end

	def test_rendering_multiple_fragments_out_of_order_from_within_cache
		cache_store = Phlex::FIFOCacheStore.new
		output = CacheTest.new(1, cache_store: cache_store).call(fragments: ["foo", "list"])
		assert_equal "<ul><li>1</li><li>2</li><li>3</li></ul>", output
	end

	def test_cache_contains_full_value_if_initially_rendered_as_fragment
		cache_store = Phlex::FIFOCacheStore.new
		output = CacheTest.new(1, cache_store: cache_store).call(fragments: ["foo"])
		assert_equal "<li>1</li>", output

		output = CacheTest.new(1, cache_store: cache_store).call
		assert_equal "<h1>Page 1</h1><div id=\"page\"><section><ul><li>1</li><li>2</li><li>3</li></ul></section></div>", output
	end

	def test_fetching_nested_fragment_from_cached_value
		cache_store = Phlex::FIFOCacheStore.new
		CacheTest.new(1, cache_store: cache_store).call # Cache the outer cache for key = 1, and the inner cache for all other keys
		output = CacheTest.new(2, cache_store: cache_store).call(fragments: ["foo"])
		assert_equal "<li>1</li>", output
	end
end
