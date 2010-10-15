require "bundler"
Bundler.setup

require "rspec"
require "rspec/core/rake_task"
Rspec::Core::RakeTask.new(:spec)

gemspec = eval(File.read("messy.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["messy.gemspec"] do
  system "gem build messy.gemspec"
  system "gem install messy-#{Messy::VERSION}.gem"
end