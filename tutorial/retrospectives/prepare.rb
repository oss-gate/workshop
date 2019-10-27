#!/usr/bin/env ruby

if ARGV.size < 1
  puts("Usage: #{$0} DIRECTORY TEMPLATE_TYPE")
  puts(" e.g.: #{$0} 2017-07-29-tokyo workshop")
  puts("")
  puts("Usage2: #{$0} LOCATION")
  puts(" e.g.: #{$0} tokyo")
  puts(" # With this usage, you can specify DATE and TEMPLATE_TYPE")
  puts(" # interactively.")
  puts("")
  puts("# TEMPLATE_TYPE is used to specify the type of template files")
  puts("# to be copied into DIRECTORY.")
  puts("#  e.g.: ./workshop-beginner.yaml is copied to ./DIRECTORY/beginner.yaml ")
  exit(false)
end

require "fileutils"
require "date"

def date_part(date = Date.today)
  date.strftime("%Y-%m-%d")
end

def set_arguments_interactively(args)
  args.values.each do |arg|
    default = arg[:default]
    print "#{arg[:label]} [#{default}]: "
    STDOUT.flush
    value = gets.chomp
    arg[:value] = value.empty? ? default : value
  end
end

args = {
  date: {
    label: "DATE",
    default: date_part,
    value: nil
  },
#  location: {
#    label: "LOCATION",
#    default: nil,
#    value: nil
#  },
  type: {
    label: "TEMPLATE_TYPE",
    default: "workshop",
    value: nil
  }
}

if ARGV.size == 1 # when a location is specified.
  location = ARGV.shift
  set_arguments_interactively(args)
  directory = "#{args[:date][:value]}-#{location}"
  type = args[:type][:value]
else
  directory = ARGV.shift
  type = ARGV.shift
end


if File.directory?(directory)
  puts("Directory already exists: #{directory}")
  exit(false)
end

FileUtils.mkdir_p(directory)
Dir.glob("#{type}-*.yaml").each do |yaml|
  yaml_without_type_prefix = yaml.sub(/\A#{Regexp.escape(type)}-/, "")
  FileUtils.cp(yaml, "#{directory}/#{yaml_without_type_prefix}")
end
