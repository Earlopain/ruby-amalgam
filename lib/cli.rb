require 'optparse'
require 'open3'

available_rubies = Dir.glob("*.*.*", base: "/root/.rbenv/versions").to_h do |full_version|
  [full_version[0..2].to_f, full_version]
end

ARGV << "--help" if ARGV.empty?

options = {}
option_parser = OptionParser.new do |opt|
  opt.banner = "Usage: docker compose run amalgam [options] <command>"

  opt.on('--all') { |o| options[:all] = true }
  opt.on('--start VERSION') { |o| options[:start] = o.to_f }
  opt.on('--stop VERSION') { |o| options[:stop] = o.to_f }
  opt.on('--only VERSION') { |o| options[:only] = o.to_f }
end
option_parser.parse!
options[:all] = true if options.empty?
command = ARGV.first

if ARGV.count != 1
  puts option_parser
  exit(1)
end

if options[:all]
  versions = available_rubies
elsif options[:only]
  versions = available_rubies.slice(options[:only])
elsif options[:start] && options[:stop]
  versions = available_rubies.select { |k, _| k >= options[:start] && k <= options[:stop] }
elsif options[:start]
  versions = available_rubies.select { |k, _| k >= options[:start] }
elsif options[:stop]
  versions = available_rubies.select { |k, _| k <= options[:stop] }
end

versions.keys.sort.each do |short_version|
  full_version = versions[short_version]
  ruby_path = "/root/.rbenv/versions/#{full_version}"
  gem_home = "/app/gems/#{full_version}"

  shell_env = {
    "BUNDLE_SILENCE_ROOT_WARNING" => "true",
    "GEM_HOME" => gem_home,
    "PATH" => "#{ruby_path}/bin:#{gem_home}/bin:#{ENV['PATH']}"
  }
  puts full_version.center(41, "=")
  system(shell_env, command)
end
