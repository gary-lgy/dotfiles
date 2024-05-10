if not status --is-interactive
    exit
end

function _insert_before
    set -l value $argv[1]
    set -l place $argv[2]
    set -l ls_name $argv[3] # name of the variable to be dereferenced using $$
    set -l ls_values $$ls_name

    if not contains $place $ls_values
        return 1
    end

    set -l i (contains -i $place $ls_values)
    if test $i = 1
        set --prepend $ls_name $value
    else
        set $ls_name $ls_values[1..(math $i - 1)] $value $ls_values[$i..]
    end

    return 0
end

if functions -q _tide_item_custom_hostname; and not contains custom_hostname $tide_left_prompt_items
    # insert custom_hostname before pwd
    _insert_before custom_hostname pwd tide_left_prompt_items
end

if functions -q _tide_item_proxy; and not contains proxy $tide_left_prompt_items
    # put proxy before newline in left prompt items
    if not _insert_before proxy newline tide_left_prompt_items
        set --append tide_left_prompt_items proxy
    end
end
