#!/usr/bin/env ruby
#
if ARGV.size < 2
  puts("Usage: #{$0} DIRECTORY TYPE")
  puts(" e.g.: #{$0} 2016-06-09 workshop")
  puts(" e.g.: #{$0} 2016-06-09 meetup")
  exit(false)
end

directory = ARGV.shift
type = ARGV.shift

unless (Dir.glob("#{directory}").empty?)
  puts("#{directory}: Directory exists.")
  exit(false)
end

require 'fileutils'

Dir.mkdir(directory)
Dir.glob("#{type}*yaml").each do |yaml|
  FileUtils.cp(yaml, "#{directory}/" + yaml.sub("#{type}-", ""))
end
