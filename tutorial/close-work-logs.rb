#!/usr/bin/env ruby

require "date"
require "json"
require "optparse"

repository = ENV["GITHUB_REPOSITORY"] || "oss-gate/workshop"
author = nil
dry_run = false
parser = OptionParser.new
parser.banner = <<-BANNER
Usage: #{$0} [options] [DATE]

Close work log issues for finished workshops with a comment.

 e.g.: #{$0}            # All work logs for past workshops
 e.g.: #{$0} 2026-08-05 # Only work logs for the 2026-08-05 workshop
 e.g.: #{$0} --dry-run
BANNER
parser.on("--repository=REPOSITORY",
          "Target repository",
          "(default: #{repository})") do |value|
  repository = value
end
parser.on("--author=AUTHOR",
          "Only close work logs created by AUTHOR") do |value|
  author = value
end
parser.on("--dry-run",
          "Only show which issues would be closed") do
  dry_run = true
end
begin
  parser.parse!
rescue OptionParser::ParseError
  $stderr.puts($!.message)
  $stderr.puts(parser.help)
  exit(false)
end

target_date = ARGV.shift
unless target_date.nil?
  begin
    target_date = Date.parse(target_date)
  rescue Date::Error
    $stderr.puts("invalid date: #{target_date}")
    exit(false)
  end
end

COMMENT = <<-COMMENT
おつかれさまでした！

ワークショップの終了にともないissueを閉じますが、このまま作業メモとして使っても構いません :ok_hand:

[ワークショップの感想](https://oss-gate.github.io/workshop/report.html)を集めています！

ブログなどに書かれた際は、[このページ](https://github.com/oss-gate/oss-gate.github.io/blob/main/workshop/report.md)へリンクの追加をお願いします :pray:

またの参加をお待ちしています！
COMMENT

def gh(*args)
  IO.pipe do |input, output|
    system("gh", *args, out: output)
    output.close
    JSON.parse(input.read)
  end
end

DATE_CHUNK = /\A#?(\d{4})-(\d{1,2})-(\d{1,2})\z/

def parse_title(title)
  date = nil
  chunks = title.split(":").collect do |chunk|
    chunk = chunk.strip
    if date.nil? and DATE_CHUNK =~ chunk
      date = Date.new($1.to_i, $2.to_i, $3.to_i)
      date.iso8601
    else
      chunk
    end
  end
  [date, chunks.join(": ")]
end

list_args = [
  "issue",
  "list",
  "--repo", repository,
  "--state", "open",
  "--label", "work log",
  "--limit", "1000",
  "--json", "number,title",
]
list_args.concat(["--author", author]) unless author.nil?
issues = gh(*list_args)

today = Date.today
issues.sort_by {|issue| issue["number"]}.each do |issue|
  title = issue["title"]
  date, normalized_title = parse_title(title)
  next if date.nil?
  if target_date
    next unless date == target_date
  else
    next unless date < today
  end

  number = issue["number"]
  if dry_run
    puts("Would close ##{number}: #{title}")
    if normalized_title != title
      puts("  Would rename to: #{normalized_title}")
    end
    next
  end

  puts("Closing ##{number}: #{title}")
  if normalized_title != title
    system("gh",
           "issue",
           "edit",
           number.to_s,
           "--repo", repository,
           "--title", normalized_title)
  end
  system("gh",
         "issue",
         "close",
         number.to_s,
         "--repo", repository,
         "--comment", COMMENT,
         "--reason", "completed")
end
