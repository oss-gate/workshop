#!/usr/bin/env ruby
# json2yaml.rb -- Convert a JSON file to a YAML file
# Copyright 2025 Keisuke Kurosawa
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# frozen_string_literal: true

require 'json'
require 'yaml'

def main
  path = ARGV.shift
  output_dir = ARGV.shift

  begin
    json2yaml(path, output_dir)
  rescue ArgumentError => e
    warn "#{$PROGRAM_NAME}: #{e.message}"
    return 1
  end

  0
end

def json2yaml(path, output_dir = nil)
  raise(ArgumentError, "#{path}: Is not a JSON file") unless File.basename(path) =~ /\.json$/

  output_dir = File.dirname(path) if output_dir.to_s.empty?

  yaml_path = "#{output_dir}/#{File.basename(path, '.json')}.yaml"

  obj = JSON.load_file(path)

  File.open(yaml_path, 'w') { |file| YAML.dump(obj, file) }
end

if __FILE__ == $PROGRAM_NAME
  errno = main

  exit(errno)
end
