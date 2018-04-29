#!/usr/bin/env ruby

@args = {}

def load_args
  ARGV.each_with_index do |arg, index|
    if index == 0
      @args[:url] = arg
    end
  end
end

def load_gem(name, version=nil)
  # needed if your ruby version is less than 1.9
  require 'rubygems'

  begin
    gem name, version
  rescue LoadError
    version = "--version '#{version}'" unless version.nil?
    system("gem install #{name} #{version}")
    Gem.clear_paths
    retry
  end

  require name
end

load_gem 'parseconfig'

load_args

if File.exist?(File.join(ENV['HOME'], '.gitconfig'))
  config_file = File.join ENV['HOME'], '.gitconfig'
  config = ParseConfig.new config_file
  if config['github'].nil?
    puts 'github section not found in ~/.gitconfig'
  else
    gh_user = config['github']['user']
    gh_token = config['github']['token']
    if gh_user.nil? || gh_token.nil?
      puts 'user and token are required'
    else
      system "curl -u #{gh_user}:#{gh_token} #{@args[:url]}"
    end
  end
else
  puts 'Git is not set up yet'
end
