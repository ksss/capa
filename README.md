capa
===

# Usage

```ruby
a = Array.new_capa(1000)
p a.length #=> 0
p a.capa #=> 1000
a.push 1,2,3
p a.length #=> 3
p a.capa #=> 1000
```

# Build & Testing

```
$ bundle ex rake
```

# Benchmark

make benchmark/{bench.memory}.png

```
$ bundle ex rake benchmark
```
