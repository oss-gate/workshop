#!/usr/bin/env ruby

Dir.chdir(__dir__)

require "json"

id = ARGV[0]

def gh(*args)
  IO.pipe do |input, output|
    system("gh", *args, 1 => output)
    output.close
    JSON.parse(input.read)
  end
end

def indent(text, width)
  text.lines.collect {|line| (" " * width) + line}.join
end

["beginner", "supporter"].each do |type|
  template = File.read("ruby-#{type}.yaml")
  issues = gh("issue",
              "list",
              "--repo", "oss-gate/workshop",
              "--search", "label:ruby label:retrospective label:#{type}",
              "--json", [
                "author",
                "body",
                "number",
                "title",
              ].join(","))
  issues.each do |issue|
    _, *answers = issue["body"].strip.split(/^### .*$/)
    answer = template.dup
    indent_width = 4
    answers.each do |text|
      answer.sub!(indent("(ここに回答を改行を入れずに書いてください)",
                         indent_width)) do
        indent(text.strip, indent_width)
      end
    end
    login = issue["author"]["login"]
    number = issue["number"]
    output = "#{id}/#{type}-#{login}.yaml"
    File.write(output, answer)
    system("git", "add", output)
    system("git", "commit", "-m", <<-MESSAGE)
ruby retrospective: Add answer by #{login}

Fix \##{number}

Co-authored-by: #{issue["author"]["name"]} <#{login}@users.noreply.github.com>
    MESSAGE
    system("gh",
           "issue",
           "close",
           number.to_s,
           "--repo", "oss-gate/workshop",
           "--comment", <<-COMMENT,
Rubyエコシステム開発入門ワークショップの参加ありがとうございました！引き続きRubyエコシステムの開発に参加していきましょう！！！
           COMMENT
           "--reason", "completed")
    system("git", "push")
  end
end
