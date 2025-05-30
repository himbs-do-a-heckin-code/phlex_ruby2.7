#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "lib/phlex"
require "benchmark/ips"

require_relative "fixtures/page"
require_relative "fixtures/layout"

#RubyVM::YJIT.enable

sample = Example::Page.new.call
puts sample.bytesize

Benchmark.ips do |x|
	x.time = 5
	x.report("Page") { Example::Page.new.call }
end
