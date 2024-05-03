# Tide prmopt item to display the custom host name.
# This can be used when it's not possible to change the "official" host name.

# color
# need to be universal variable and follow the naming scheme tide_ITEMNAME_color
set -U tide_custom_hostname_color yellow
set -U tide_custom_hostname_bg_color normal

# prompt item
function _tide_item_custom_hostname
    # fallback to "official" hostname
    set --function text (hostname)

    # set this variable to change the text
    if set -q tide_custom_hostname
        set --function text $tide_custom_hostname
    end

    _tide_print_item custom_hostname $text
end

if not contains custom_hostname $tide_right_prompt_items
    set --prepend tide_right_prompt_items custom_hostname
end
