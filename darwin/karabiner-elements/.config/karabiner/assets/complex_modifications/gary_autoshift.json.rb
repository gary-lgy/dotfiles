#!/usr/bin/env ruby

require 'json'
require_relative '../lib/key_codes'

def main
  puts JSON.pretty_generate(
    {
      'title': 'Gary Liu\'s autoshift mode',
      'rules': [
        {
          'description': 'Gary Liu\'s autoshift - numbers',
          'manipulators': generate_autoshift(('0'..'9').to_a)
        },
        {
          'description': 'Gary Liu\'s autoshift - symbols',
          'manipulators': generate_autoshift(%w[grave_accent_and_tilde hyphen equal_sign open_bracket close_bracket backslash semicolon quote comma period slash])
        }
      ]
    }
  )
end

def generate_autoshift(keys)
  keys.map do |key|
    {
      "type": "basic",
      "from": {
        "key_code": key,
        "modifiers": {
          "optional": ['any']
        }
      },
      "to_if_held_down": [
        {
          "key_code": key,
          "modifiers": ["left_shift"],
          "repeat": false,
          "halt": true
        }
      ],
      "to_after_key_up": [
        {
          "key_code": key,
          "repeat": false
        }
      ],

      'parameters' => {
        'basic.to_if_held_down_threshold_milliseconds': 200,
      },
    }
  end
end

main()
