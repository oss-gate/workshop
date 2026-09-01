#!/usr/bin/env ruby

require "optparse"
require "yaml"

format = "text"
parser = OptionParser.new
parser.banner = <<-BANNER
Usage: #{$0} [options] DIRECTORY [TYPE [QUESTION]]
 e.g.: #{$0} 2016-06-09
 e.g.: #{$0} 2016-06-09 beginner
 e.g.: #{$0} 2016-06-09 beginner motivation
 e.g.: #{$0} --format=markdown 2016-06-09
BANNER
parser.on("--format=FORMAT", ["text", "markdown"],
          "Output format (text or markdown)",
          "(default: #{format})") do |value|
  format = value
end
begin
  parser.parse!
rescue OptionParser::ParseError
  $stderr.puts($!.message)
  $stderr.puts(parser.help)
  exit(false)
end

if ARGV.size < 1
  puts(parser.help)
  exit(false)
end

directory = ARGV.shift
type = ARGV.shift
target_question = ARGV.shift

def aggregate(directory, type, target_question, format)
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
  return false unless result
  return true if questionnaires.size == 0

  if format == "markdown"
    puts("## #{type}")
    puts
  end

  _, key_questionnairy = questionnaires.first
  key_questionnairy["questions"].each do |question, _|
    unless target_question.nil?
      next unless question == target_question
    end

    case format
    when "markdown"
      puts("### #{question}")
      puts
      questionnaires.each do |account, questionnairy|
        answer = questionnairy["questions"][question]
        puts("#### #{account}")
        puts
        if answer.is_a?(Array)
          puts(answer.join("\n"))
        else
          puts(answer)
        end
        puts
      end
    else
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
  end
  result
end

if type
  types = [type]
else
  types = ["beginner", "supporter"]
  if format == "markdown"
    puts("# Aggregated retrospectives")
    puts
  end
end
result = true
types.each do |type|
  unless aggregate(directory, type, target_question, format)
    result = false
  end
end
exit(result)
