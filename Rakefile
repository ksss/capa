require "bundler/gem_tasks"
require 'rake/extensiontask'
require 'rake/testtask'

task :default => [:compile, :test]

Rake::ExtensionTask.new('ext') do |ext|
  ext.ext_dir = 'ext/capa'
  ext.lib_dir = 'lib/capa'
end
Rake::TestTask.new {|t| t.libs << 'test'}

task :benchmark do
  ruby "benchmark/bench.rb"
end
