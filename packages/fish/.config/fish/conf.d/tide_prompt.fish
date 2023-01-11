# tide prmopt item to display whether proxy is enabled

# icon
set -U tide_proxy_icon 䀹

# color
set -U tide_proxy_color CCFF00
set -U tide_proxy_bg_color normal

# prompt item
function _tide_item_proxy
    begin
        env | grep -i -q 'all_proxy=\|http_proxy=\|https_proxy='
    end && _tide_print_item proxy $tide_proxy_icon
end

if not contains proxy $tide_right_prompt_items
    set --append tide_right_prompt_items proxy
end
