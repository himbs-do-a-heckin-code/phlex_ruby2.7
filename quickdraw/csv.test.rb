require "minitest/autorun"
require "phlex"

class CSVTest < Minitest::Test
	Product = Struct.new(:name, :price)

	class Base < Phlex::CSV
		def row_template(product)
			column("name", product.name)
			column("price", product.price)
		end
	end

	def setup
		@products = [
			Product.new("Apple", 1.00),
			Product.new(" Banana ", 2.00),
			Product.new(:strawberry, "Three pounds"),
			Product.new("=SUM(A1:B1)", "=SUM(A1:B1)"),
			Product.new("Abc, \"def\"", "Foo\nbar \"baz\""),
			Product.new("", ""),
			Product.new(nil, nil),
		]
	end

	def test_dont_escape_csv_injection_or_trim_whitespace
		example = Class.new(Base) do
			define_method(:escape_csv_injection?) { false }
			define_method(:trim_whitespace?) { false }
		end

		assert_equal <<~CSV, example.new(@products).call
			name,price
			Apple,1.0
			" Banana ",2.0
			strawberry,Three pounds
			=SUM(A1:B1),=SUM(A1:B1)
			"Abc, ""def""","Foo\nbar ""baz"""
			"",""
			"",""
		CSV
	end

	def test_dont_escape_csv_injection_but_do_trim_whitespace
		example = Class.new(Base) do
			define_method(:escape_csv_injection?) { false }
			define_method(:trim_whitespace?) { true }
		end

		assert_equal <<~CSV, example.new(@products).call
			name,price
			Apple,1.0
			Banana,2.0
			strawberry,Three pounds
			=SUM(A1:B1),=SUM(A1:B1)
			Abc, "def",Foo\nbar "baz"
			,
			,
		CSV
	end

	def test_escape_csv_injection_but_dont_trim_whitespace
		example = Class.new(Base) do
			define_method(:escape_csv_injection?) { true }
			define_method(:trim_whitespace?) { false }
		end

		assert_equal <<~CSV, example.new(@products).call
			name,price
			Apple,1.0
			" Banana ",2.0
			strawberry,Three pounds
			"'=SUM(A1:B1)","'=SUM(A1:B1)"
			"Abc, ""def""","Foo\nbar ""baz"""
			"",""
			"",""
		CSV
	end

	def test_escape_csv_injection_and_trim_whitespace
		example = Class.new(Base) do
			define_method(:escape_csv_injection?) { true }
			define_method(:trim_whitespace?) { true }
		end

		assert_equal <<~CSV, example.new(@products).call
			name,price
			Apple,1.0
			Banana,2.0
			strawberry,Three pounds
			"'=SUM(A1:B1)","'=SUM(A1:B1)"
			"Abc, ""def""","Foo\nbar ""baz"""
			,
			,
		CSV
	end

	def test_no_headers
		example = Class.new(Base) do
			define_method(:render_headers?) { false }
			define_method(:escape_csv_injection?) { false }
		end

		assert_equal <<~CSV, example.new(@products).call
			Apple,1.0
			" Banana ",2.0
			strawberry,Three pounds
			=SUM(A1:B1),=SUM(A1:B1)
			"Abc, ""def""","Foo\nbar ""baz"""
			"",""
			"",""
		CSV
	end

	def test_with_custom_around_row
		example = Class.new(Phlex::CSV) do
			def escape_csv_injection?; true; end

			def around_row(item)
				super(item.name, item.price)
			end

			def row_template(name, price)
				column "Name", name
				column "Price", price
			end
		end

		assert_equal <<~CSV, example.new(@products).call
			Name,Price
			Apple,1.0
			" Banana ",2.0
			strawberry,Three pounds
			"'=SUM(A1:B1)","'=SUM(A1:B1)"
			"Abc, ""def""","Foo\nbar ""baz"""
			"",""
			"",""
		CSV
	end

	def test_with_around_row_calling_super_twice
		example = Class.new(Phlex::CSV) do
			def escape_csv_injection?; true; end
			def trim_whitespace?; false; end

			def around_row(item)
				super(item.name, item.price)
				super(item.name, item.price)
			end

			def row_template(name, price)
				column "Name", name
				column "Price", price
			end
		end

		assert_equal <<~CSV, example.new(@products).call
			Name,Price
			Apple,1.0
			Apple,1.0
			" Banana ",2.0
			" Banana ",2.0
			strawberry,Three pounds
			strawberry,Three pounds
			"'=SUM(A1:B1)","'=SUM(A1:B1)"
			"'=SUM(A1:B1)","'=SUM(A1:B1)"
			"Abc, ""def""","Foo\nbar ""baz"""
			"Abc, ""def""","Foo\nbar ""baz"""
			"",""
			"",""
			"",""
			"",""
		CSV
	end

	def test_with_yielder_yielding_twice
		example = Class.new(Phlex::CSV) do
			def escape_csv_injection?; true; end
			def trim_whitespace?; false; end

			def yielder(item)
				yield(item.name, item.price)
				yield(item.name, item.price)
			end

			def row_template(name, price)
				column "Name", name
				column "Price", price
			end
		end

		assert_equal <<~CSV, example.new(@products).call
			Name,Price
			Apple,1.0
			Apple,1.0
			" Banana ",2.0
			" Banana ",2.0
			strawberry,Three pounds
			strawberry,Three pounds
			"'=SUM(A1:B1)","'=SUM(A1:B1)"
			"'=SUM(A1:B1)","'=SUM(A1:B1)"
			"Abc, ""def""","Foo\nbar ""baz"""
			"Abc, ""def""","Foo\nbar ""baz"""
			"",""
			"",""
			"",""
			"",""
		CSV
	end

	def test_with_custom_delimiter_defined_as_method
		example = Class.new(Phlex::CSV) do
			define_method(:escape_csv_injection?) { true }
			define_method(:trim_whitespace?) { true }
			define_method(:delimiter) { ";" }
			define_method(:row_template) do |product|
				column "Name", product.name
				column "Price", product.price
			end
		end

		assert_equal <<~CSV, example.new(@products).call
			Name;Price
			Apple;1.0
			Banana;2.0
			strawberry;Three pounds
			"'=SUM(A1:B1)";"'=SUM(A1:B1)"
			"Abc, ""def""";"Foo\nbar ""baz"""
			;
			;
		CSV
	end

	def test_with_custom_delimiter_passed_as_argument
		example = Class.new(Phlex::CSV) do
			define_method(:escape_csv_injection?) { true }
			define_method(:trim_whitespace?) { true }
			define_method(:row_template) do |product|
				column "Name", product.name
				column "Price", product.price
			end
		end

		assert_equal <<~CSV, example.new(@products).call(delimiter: ";")
			Name;Price
			Apple;1.0
			Banana;2.0
			strawberry;Three pounds
			"'=SUM(A1:B1)";"'=SUM(A1:B1)"
			"Abc, ""def""";"Foo\nbar ""baz"""
			;
			;
		CSV
	end
end
