#!/usr/bin/env ruby

require "fileutils"
require "uri"
require "net/http"
require "json"

if ARGV.size < 1
  puts("Usage: #{$0} DIRECTORY")
  puts(" e.g.: #{$0} 2022-09-06-online")
  exit(false)
end

def get_beginner_names_from_issue_titles
  uri = URI("https://api.github.com/repos/oss-gate/workshop/issues")
  res = Net::HTTP.get_response(uri)
  return [] unless res.is_a?(Net::HTTPSuccess)

  issues = JSON.parse(res.body)

  # Assume the following title format:
  # OSS Gate Workshop: ${LOCATION}: ${YEAR}-${MONTH}-${DAY}: ${ACCOUNT_NAME}: ${OSS_NAME}: Work log
  names = issues
    .select { |issue| issue["title"].start_with?("OSS Gate Workshop:") }
    .map { |issue| issue["title"].split(":")[3].strip }

  return names
end

directory = ARGV.shift

unless File.directory?(directory)
  puts("Directory does NOT exist: #{directory}")
  puts("You need to prepare the directory by 'prepare.rb'.")
  exit(false)
end

names = get_beginner_names_from_issue_titles

if names.size == 0
  puts("Could not find beginner names.")
  exit(false)
end

names.each do |name|
  FileUtils.cp("#{directory}/beginner.yaml", "#{directory}/beginner-#{name}.yaml")
  puts("Created a file for: #{name}")
end
