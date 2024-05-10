# tide prmopt item to display whether proxy is enabled

# icon
set -U tide_proxy_icon 󰗕

# color
set -U tide_proxy_color $tide_status_color
set -U tide_proxy_bg_color $tide_status_bg_color

# prompt item
function _tide_item_proxy
    begin
        env | grep -i -q 'all_proxy=\|http_proxy=\|https_proxy='
    end && _tide_print_item proxy $tide_proxy_icon
end

