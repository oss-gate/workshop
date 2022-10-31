#!/usr/bin/env ruby

require "uri"
require "net/http"
require "json"
require "date"

if ARGV.size > 0
  puts("Usage: #{$0}")
  exit(false)
end

$keywords = [
  "開催1ヵ月前",
  "開催2週間前",
  "開催1週間前",
  "開催3日前",
  "開催1日前",
]

def calc_date(date, keyword)
  case keyword
  when "開催1ヵ月前"
    date << 1
  when "開催2週間前"
    date - 14
  when "開催1週間前"
    date - 7
  when "開催3日前"
    date - 3
  when "開催1日前"
    date - 1
  else
    raise "Invalid keyword"
  end
end

def get_preparation_issues
  uri = URI("https://api.github.com/repos/oss-gate/workshop/issues")
  res = Net::HTTP.get_response(uri)
  return [] unless res.is_a?(Net::HTTPSuccess)

  issues = JSON.parse(res.body)

  issues.select { |issue| issue["title"].start_with?("OSS Gateオンラインワークショップ") }
end

def convert_body(body, date)
  body.gsub(/(開催.+前)（YYYY-MM-DD）/) do
    before = Regexp.last_match[1]
    "#{before}（#{calc_date(date, before)}）"
  end
end

get_preparation_issues.each do |issue|
  date = Date.parse(issue["title"].delete_prefix("OSS Gateオンラインワークショップ"))
  body_converted_dates = convert_body(issue["body"], date)

  puts issue["title"]
  puts
  puts body_converted_dates
  puts
  puts "-" * 20
  puts
end
