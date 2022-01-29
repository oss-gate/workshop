#!/usr/bin/env ruby

if ARGV.size < 2
  puts("Usage: #{$0} DIRECTORY TYPE [QUESTION]")
  puts(" e.g.: #{$0} 2016-06-09 beginner")
  puts(" e.g.: #{$0} 2016-06-09 beginner motivation")
  exit(false)
end

require "yaml"

directory = ARGV.shift
type = ARGV.shift
target_question = ARGV.shift
result = true

questionnaires = {}
Dir.glob("#{directory}/#{type}-*.y{,a}ml").sort.each do |yaml|
  if File.basename(yaml) =~ /#{type}-(.+)\.ya?ml/
    account = $1
    begin
      questionnaires[account] = YAML.load(File.read(yaml, encoding: 'BOM|UTF-8'))
    rescue Psych::SyntaxError
      $stderr.puts("#{account}: syntax error: #{$!}")
      result = false
    end
  end
end
exit(false) unless result
exit(true) if questionnaires.size == 0

_, key_questionnairy = questionnaires.first
key_questionnairy["questions"].each do |question, _|
  unless target_question.nil?
    next unless question == target_question
  end

  puts("-" * question.size)
  puts(question)
  puts("-" * question.size)
  questionnaires.each do |account, questionnairy|
    answer = questionnairy["questions"][question]
    if answer.is_a?(Array)
      puts("#{account}:")
      puts(answer.join("\n"))
    else
      puts("#{account}: #{answer}")
    end
    puts("=" * 40)
  end
  puts
end
exit(result)
