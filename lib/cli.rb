require 'optparse'
require 'open3'

available_rubies = Dir.children("/root/.rbenv/versions").to_h do |full_version|
  [full_version[0..2].to_f, full_version]
end

# https://stackoverflow.com/a/40434335
class OptionParser
  # Like order!, but leave any unrecognized --switches alone
  def order_recognized!(args)
    extra_opts = []
    begin
      order!(args) { |a| extra_opts << a }
    rescue OptionParser::InvalidOption => e
      extra_opts << e.args[0]
      retry
    end
    args[0, 0] = extra_opts
  end
end

options = {}
OptionParser.new do |opt|
  opt.banner = "Usage: docker compose run amalgam [options] [ruby_options]"

  # FIXME: do some validation
  opt.on('--all') { |o| options[:all] = true }
  opt.on('--start VERSION') { |o| options[:start] = o.to_f }
  opt.on('--stop VERSION') { |o| options[:stop] = o.to_f }
  opt.on('--only VERSION') { |o| options[:only] = o.to_f }
end.order_recognized!(ARGV)
ruby_options = ARGV

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
  result, _status = Open3.capture2e("/root/.rbenv/versions/#{full_version}/bin/ruby", *ruby_options)
  puts <<~TEXT
    #{full_version.center(41, "=")}
    #{result}
  TEXT
end
