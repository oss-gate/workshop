#!/usr/bin/env ruby

if ARGV.size < 2
  puts("Usage: #{$0} DIRECTORY TYPE")
  puts(" e.g.: #{$0} 2017-07-29-tokyo workshop")
  exit(false)
end

require "fileutils"

directory = ARGV.shift
type = ARGV.shift

if File.directory?(directory)
  puts("Directory already exists: #{directory}")
  exit(false)
end

FileUtils.mkdir_p(directory)
Dir.glob("#{type}-*.yaml").each do |yaml|
  yaml_no_type = yaml.sub(/\A#{Regexp.escape(type)}-/, "")
  FileUtils.cp(yaml, "#{directory}/#{yaml_no_type}")
end
