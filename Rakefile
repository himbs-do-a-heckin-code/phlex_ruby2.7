require 'rake/testtask'
require_relative 'config/minitest'

desc 'Run unit tests'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.libs << 'fixtures'
  t.pattern = 'quickdraw/**/*.test.rb'
end