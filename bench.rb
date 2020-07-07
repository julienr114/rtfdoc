require 'benchmark/ips'
# require 'erubi'
#
# buf = Erubi::Engine.new('
# <div class="list-item-label">
#   <div class="list-item-name"><%= @name %></div>
#   <div class="list-item-type"><%= @type %></div>
# </div>')
#
# @name = 'foo'
# @type = 'string'
#
# def method(name, type)
#   '<div class="list-item-label"><div class="list-item-name">' << name << '</div><div class="list-item-type">' << type << '</div></div>'
# end
#
# foo = Class.new {
#   def initialize(name, type)
#     @name, @type = name, type
#   end
#
#   class_eval("define_method(:_template) { #{buf.src} }")
# }
#
# puts foo.new(@name, @type)._template
#
# Benchmark.ips do |x|
#   x.report('eval') { eval(buf.src) }
#   x.report('meth') { foo.new(@name, @type)._template }
#
#   x.compare!
# end


str = 'content/intro/example.md'

def meth1(str)
  str.split('/').last.split('.').first
end

def meth2(str)
  str.split('/').last.slice(0..-4)
end

def meth3(str)
  i = str.rindex('/')
  str.slice(i + 1..-4)
end

def meth4(str)
  /(?<name>\w+)\.md\Z/.match(str)[:name]
end

def meth5(str)
  i = str.rindex('/')
  str.slice(i + 1, str.length - i - 4)
end

puts meth5(str)

Benchmark.ips do |x|
  x.report('meth1') { meth1(str) }
  x.report('meth2') { meth2(str) }
  x.report('meth3') { meth3(str) }
  x.report('meth4') { meth4(str) }
  x.report('meth5') { meth5(str) }

  x.compare!
end
