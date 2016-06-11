#!/usr/bin/env ruby

if ARGV.size != 1
  puts("Usage: #{$0} DIRECTORY")
  puts(" e.g.: #{$0} 2016-06-09")
  exit(false)
end

require "yaml"

directory = ARGV.first

# TODO...

beginners = {}
Dir.glob("#{directory}/beginner-*.yaml") do |beginner_yaml|
  beginner = YAML.load(File.read(beginner_yaml))
  p beginner
end

mentors = {}
Dir.glob("#{directory}/mentor-*.yaml") do |mentor_yaml|
  mentor = YAML.load(File.read(mentor_yaml))
  p mentor
end
