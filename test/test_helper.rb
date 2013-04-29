require 'rubygems'
require 'minitest/autorun'

ENV['NOWHEN_DB'] = File.expand_path '../tmp/test.sqlite', File.dirname(__FILE__)
$:.unshift File.expand_path '../lib', File.dirname(__FILE__)
require 'nowhen'
