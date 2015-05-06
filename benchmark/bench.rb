require_relative '../lib/capa'
require 'benchmark'
require "gnuplot"
require 'objspace'

class DataSet < Struct.new(:name, :build, :result); end
class Result < Struct.new(:x, :y, :memory); end
class Output < Struct.new(:filename, :data, :with); end

datasets = [
	DataSet.new("Array.new", ->(n){ Array.new }, nil),
	DataSet.new("Array.new\\_capa", ->(n){ Array.new_capa(n) }, nil),
].map do |d|
	x = []
	y = []
	memory = []
	0.step(to: 100, by: 1).each do |n|
		GC.start
		GC.disable
		i = 0
		before = ObjectSpace.memsize_of_all
		real = Benchmark.realtime do
			a = d.build.call(n)
			while i < n
				a.push i
				i += 1
			end
		end
		after = ObjectSpace.memsize_of_all
		GC.enable
		memory << (after - before)
		x << n
		y << real.to_f * 1000
	end
	d.result = Result.new(x, y, memory)
	d
end

[
	Output.new('bench.png', ->(d){[d.result.x, d.result.y]}, :dots),
  Output.new('memory.png', ->(d){[d.result.x, d.result.memory]}, :lines),
].each do |output|
	Gnuplot.open do |gp|
		Gnuplot::Plot.new( gp ) do |plot|
	    plot.terminal 'png'
	    plot.output File.expand_path("../#{output.filename}", __FILE__)
			plot.title  'bencnmark'
			plot.ylabel 'time(ms)'
			plot.xlabel 'push times'

			datasets.each do |dataset|
		    plot.data << Gnuplot::DataSet.new(output.data.call(dataset)) do |ds|
		      ds.with = output.with.to_s
		      ds.title = dataset.name
		    end
			end
		end
	end
end
