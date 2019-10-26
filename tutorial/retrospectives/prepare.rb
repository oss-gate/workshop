#!/usr/bin/env ruby

if ARGV.size < 2
  puts("Usage: #{$0} DIRECTORY TEMPLATE_TYPE")
  puts(" e.g.: #{$0} 2017-07-29-tokyo workshop")
  puts("")
  puts("TEMPLATE_TYPE is used to specify the type of template files")
  puts("to be copied into DIRECTORY.")
  puts(" e.g.: ./workshop-beginner.yaml is copied to ./DIRECTORY/beginner.yaml ")
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
  yaml_without_type_prefix = yaml.sub(/\A#{Regexp.escape(type)}-/, "")
  FileUtils.cp(yaml, "#{directory}/#{yaml_without_type_prefix}")
end
