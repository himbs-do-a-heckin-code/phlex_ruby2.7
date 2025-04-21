# frozen_string_literal: true

require "minitest/autorun"
require "phlex"
include Phlex::Helpers

class MixTest < Minitest::Test
	def test_nil_plus_string
		output = mix({ class: nil }, { class: "a" })
		assert_equal output, { class: "a" }
	end

	def test_string_plus_nil
		output = mix({ class: "a" }, { class: nil })
		assert_equal output, { class: "a" }
	end

	def test_array_plus_nil
		output = mix({ class: ["foo", "bar"] }, { class: nil })
		assert_equal output, { class: ["foo", "bar"] }
	end

	def test_array_plus_array
		output = mix({ class: ["foo"] }, { class: ["bar"] })
		assert_equal output, { class: ["foo", "bar"] }
	end

	def test_array_plus_set
		output = mix({ class: ["foo"] }, { class: Set["bar"] })
		assert_equal output, { class: ["foo", "bar"] }
	end

	def test_array_plus_hash
		output = mix(
			{ data: ["foo"] },
			{ data: { controller: "bar" } },
		)

		assert_equal output, { data: { _: ["foo"], controller: "bar" } }
	end

	def test_array_plus_string
		output = mix({ class: ["foo"] }, { class: "bar" })
		assert_equal output, { class: ["foo", "bar"] }
	end

	def test_hash_plus_hash
		output = mix(
			{ data: { controller: "foo" } },
			{ data: { controller: "bar" } },
		)

		assert_equal output, { data: { controller: "foo bar" } }
	end

	def test_string_plus_array
		output = mix({ class: "foo" }, { class: ["bar"] })
		assert_equal output, { class: ["foo", "bar"] }
	end

	def test_string_plus_string
		output = mix({ class: "foo" }, { class: "bar" })
		assert_equal output, { class: "foo bar" }
	end

	def test_string_plus_set
		output = mix({ class: "foo" }, { class: Set["bar"] })
		assert_equal output, { class: ["foo", "bar"] }
	end

	def test_override
		output = mix({ class: "foo" }, { class!: "bar" })
		assert_equal output, { class: "bar" }
	end

	def test_set_plus_set
		output = mix({ class: Set["foo"] }, { class: Set["bar"] })
		assert_equal output, { class: Set["foo", "bar"] }
	end

	def test_set_plus_array
		output = mix({ class: Set["foo"] }, { class: ["bar"] })
		assert_equal output, { class: ["foo", "bar"] }
	end

	def test_set_plus_string
		output = mix({ class: Set["foo"] }, { class: "bar" })
		assert_equal output, { class: ["foo", "bar"] }
	end
end
