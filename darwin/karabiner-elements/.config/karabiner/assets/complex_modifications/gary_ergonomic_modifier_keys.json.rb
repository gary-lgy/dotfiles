#!/usr/bin/env ruby

require 'json'
require_relative '../lib/karabiner.rb'

def main
  mappings = {
    'left_shift': ['e', 'r'],
    'right_shift': ['u', 'i'], 
    'left_control': ['d', 'f'],
    'right_control': ['j', 'k'],
    'left_option': ['c', 'v'],
    'right_option': ['n', 'm'],
  }
  puts JSON.pretty_generate(
    {
      'title': 'Gary Liu\'s ergonomic modifier keys',
      'rules': [
        map_modifier_keys_to_key_combinations(mappings),
      ].flatten
    }
  )
end

def map_modifier_keys_to_key_combinations(mappings)
  {
    'description': 'Gary Liu\'s ergonomic modifier keys',
    'manipulators': mappings.map do |modifier, combination|
      {
        'type': 'basic',
        'from': {
          'simultaneous': combination.map do |key|
            {
              'key_code': key,
            }
          end,
          'modifiers': Karabiner::from_modifiers
        },
        'to': ['key_code': modifier],
        'parameters': {
          'basic.simultaneous_threshold_milliseconds': 25
        }
      }
    end
  }
end

main()
