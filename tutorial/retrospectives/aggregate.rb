#!/usr/bin/env ruby

if ARGV.size != 3
  puts("Usage: #{$0} DIRECTORY TYPE QUESTION")
  puts(" e.g.: #{$0} 2016-06-09 beginner type")
  exit(false)
end

require "yaml"

directory = ARGV.shift
type = ARGV.shift
question = ARGV.shift

Dir.glob("#{directory}/#{type}-*.yaml") do |yaml|
  hash = YAML.load(File.read(yaml))
  puts hash["questions"][question]
end
