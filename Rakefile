#!/usr/bin/env rake

require 'rubygems'
require 'bundler'
require 'bundler/gem_tasks'
require 'rake'
require 'rake/testtask'

Bundler.setup(:default)

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end
