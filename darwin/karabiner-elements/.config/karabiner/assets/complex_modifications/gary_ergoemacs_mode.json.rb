#!/usr/bin/env ruby

PARAMETERS = {
  :to_if_alone_timeout_milliseconds => 300,
  :to_delayed_action_delay_milliseconds => 0,
  :to_if_held_down_threshold_milliseconds => 0,
  :simultaneous_threshold_milliseconds => 300,
}.freeze

require 'json'
require_relative '../lib/karabiner.rb'

def main
  puts JSON.pretty_generate(
    "title" => "Gary Liu\'s ergoemacs mode",
    "maintainers" => ["marlonrichert"],
    "rules" => [
      {
        "description" => "Gary Liu\'s ergoemacs mode",
        "manipulators" => generate_ergoemacs_mode("spacebar"),
      },
    ],
  )
end

def generate_ergoemacs_mode(trigger_key)
  variable = "ergoemacs_#{trigger_key}"
  [
    generate_ergoemacs_two_part_rule("k", "up_arrow", [], trigger_key, variable),
    generate_ergoemacs_two_part_rule("h", "left_arrow", [], trigger_key, variable),
    generate_ergoemacs_two_part_rule("j", "down_arrow", [], trigger_key, variable),
    generate_ergoemacs_two_part_rule("l", "right_arrow", [], trigger_key, variable),
    generate_ergoemacs_four_part_rule("u", "left_arrow", ["left_option"],
                                      [ { "key_code" => "escape" }, { "key_code" => "b" } ],
                                      trigger_key, variable),
    generate_ergoemacs_four_part_rule("i", "right_arrow", ["left_option"],
                                      [ { "key_code" => "escape" }, { "key_code" => "f" } ],
                                      trigger_key, variable),
    generate_ergoemacs_four_part_rule("y", "left_arrow", ["left_command"],
                                      [ { "key_code" => "a", "modifiers" => ["left_control"], } ],
                                      trigger_key, variable),
    generate_ergoemacs_four_part_rule("o", "right_arrow", ["left_command"],
                                      [ { "key_code" => "e", "modifiers" => ["left_control"], } ],
                                      trigger_key, variable),
    generate_ergoemacs_two_part_rule("d", "delete_or_backspace", [], trigger_key, variable),
    generate_ergoemacs_two_part_rule("f", "delete_forward", [], trigger_key, variable),
    generate_ergoemacs_four_part_rule("e", "delete_or_backspace", ["left_option"],
                                      [ { "key_code" => "w", "modifiers" => ["left_control"], } ],
                                      trigger_key, variable),
    generate_ergoemacs_four_part_rule("r", "delete_forward", ["left_option"],
                                      [ { "key_code" => "escape" }, { "key_code" => "d" }, ],
                                      trigger_key, variable),
    generate_ergoemacs_four_part_rule("s", "delete_or_backspace", ["left_command"],
                                      [ { "key_code" => "u", "modifiers" => ["left_control"], } ],
                                      trigger_key, variable),
    generate_ergoemacs_two_part_rule("g", "k", ["left_control"], trigger_key, variable),
    generate_ergoemacs_trigger_rule(trigger_key, variable),
  ].flatten
end

def generate_ergoemacs_trigger_rule(trigger_key, variable)
  [
    {
      "type" => "basic",
      "from" => {
        "key_code" => trigger_key,
        "modifiers" => { "optional" => ["any"] },
      },
      "to" => [
        Karabiner.set_variable("DEBUG simultaneous", 0),
        Karabiner.set_variable("DEBUG trigger alone", 0),
        Karabiner.set_variable("DEBUG trigger held down", 0),
        Karabiner.set_variable("DEBUG trigger key up", 0),
        Karabiner.set_variable("DEBUG trigger delay invoked", 0),
        Karabiner.set_variable("DEBUG trigger delay canceled", 0),
        Karabiner.set_variable("DEBUG halt", 0),
      ],
      "to_if_alone" => [
        Karabiner.set_variable("DEBUG trigger alone", 1),
        Karabiner.set_variable(variable, 0),
        Karabiner.set_variable("DEBUG halt", 1),
        {
          "key_code" => trigger_key,
          "halt" => true,
        },
      ],
      "to_if_held_down" => [
          Karabiner.set_variable("DEBUG trigger held down", 1),
          Karabiner.set_variable(variable, 1),
      ],
      "to_after_key_up" => [
        Karabiner.set_variable("DEBUG trigger key up", 1),
        Karabiner.set_variable(variable, 0),
        {
          "key_code" => "vk_none",
        },
      ],
      "to_delayed_action" => {
          "to_if_invoked" => [
            Karabiner.set_variable("DEBUG trigger delay invoked", 1),
          ],
          "to_if_canceled" => [
            Karabiner.set_variable("DEBUG trigger delay canceled", 1),
            Karabiner.set_variable(variable, 0),
            Karabiner.set_variable("DEBUG halt", 1),
            {
              "key_code" => trigger_key,
            },
          ]
      },
      'parameters' => {
        'basic.to_if_alone_timeout_milliseconds' => PARAMETERS[:to_if_alone_timeout_milliseconds],
        'basic.to_delayed_action_delay_milliseconds' => PARAMETERS[:to_delayed_action_delay_milliseconds],
        'basic.to_if_held_down_threshold_milliseconds' => PARAMETERS[:to_if_held_down_threshold_milliseconds],
      },
    },
  ]
end

def generate_ergoemacs_two_part_rule(from_key_code, to_key_code, to_modifiers, trigger_key,
                                     variable)
  [
    {
      "type" => "basic",
      "from" => {
        "key_code" => from_key_code,
        "modifiers" => { "optional" => ["any"] },
      },
      "to" => [
        {
          "key_code" => to_key_code,
          "modifiers" => to_modifiers
        },
      ],
      "conditions" => [
        Karabiner.variable_if(variable, 1),
      ]
    },

    {
      "type" => "basic",
      "from" => {
        "simultaneous" => [
          { "key_code" => trigger_key },
          { "key_code" => from_key_code },
        ],
        "simultaneous_options" => {
          "key_down_order" => "strict",
          "key_up_order" => "strict_inverse",
          "detect_key_down_uninterruptedly" => true,
          "to_after_key_up" => [
            Karabiner.set_variable(variable, 0),
          ],
        },
        "modifiers" => { "optional" => ["any"] },
      },
      "to" => [
        Karabiner.set_variable(variable, 1),
        Karabiner.set_variable("DEBUG simultaneous", 1),
        {
          "key_code" => to_key_code,
          "modifiers" => to_modifiers
        }
      ],
      'parameters' => {
        'basic.simultaneous_threshold_milliseconds' => PARAMETERS[:simultaneous_threshold_milliseconds],
      },
    },
  ]
end

def generate_ergoemacs_four_part_rule(from_key_code, normal_to_key_code, normal_to_modifiers,
                                      terminal_to, trigger_key, variable)
  [
    {
      "type" => "basic",
      "from" => {
        "key_code" => from_key_code,
        "modifiers" => { "optional" => ["any"] },
      },
      "to" => [
        {
          "key_code" => normal_to_key_code,
          "modifiers" => normal_to_modifiers,
        },
      ],
      "conditions" => [
        Karabiner.frontmost_application_unless(["terminal"]),
        Karabiner.variable_if(variable, 1),
      ]
    },

    {
      "type" => "basic",
      "from" => {
        "simultaneous" => [
          { "key_code" => trigger_key },
          { "key_code" => from_key_code },
        ],
        "simultaneous_options" => {
          "key_down_order" => "strict",
          "key_up_order" => "strict_inverse",
          "detect_key_down_uninterruptedly" => true,
          "to_after_key_up" => [
            Karabiner.set_variable(variable, 0),
          ],
        },
        "modifiers" => { "optional" => ["any"] },
      },
      "to" => [
        Karabiner.set_variable(variable, 1),
        Karabiner.set_variable("DEBUG simultaneous", 1),
        {
          "key_code" => normal_to_key_code,
          "modifiers" => normal_to_modifiers,
        },
      ],
      'parameters' => {
        'basic.simultaneous_threshold_milliseconds' => PARAMETERS[:simultaneous_threshold_milliseconds],
      },
      "conditions" => [
        Karabiner.frontmost_application_unless(["terminal"]),
      ],
    },

    {
      "type" => "basic",
      "from" => {
        "key_code" => from_key_code,
        "modifiers" => { "optional" => ["any"] },
      },
      "to" => terminal_to,
      "conditions" => [
        Karabiner.frontmost_application_if(["terminal"]),
        Karabiner.variable_if(variable, 1),
      ]
    },

    {
      "type" => "basic",
      "from" => {
        "simultaneous" => [
          { "key_code" => trigger_key },
          { "key_code" => from_key_code },
        ],
        "simultaneous_options" => {
          "key_down_order" => "strict",
          "key_up_order" => "strict_inverse",
          "detect_key_down_uninterruptedly" => true,
          "to_after_key_up" => [
            Karabiner.set_variable(variable, 0),
          ],
        },
        "modifiers" => { "optional" => ["any"] },
      },
      "to" => [
        Karabiner.set_variable(variable, 1),
      ] + terminal_to,
      'parameters' => {
        'basic.simultaneous_threshold_milliseconds' => PARAMETERS[:simultaneous_threshold_milliseconds],
      },
      "conditions" => [
        Karabiner.frontmost_application_if(["terminal"]),
      ],
    },
  ]
end

main()
