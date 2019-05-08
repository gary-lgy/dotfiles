function ag --wraps='ag' --description 'Run ag taking into account ~/.ignore and following symlinks'
  command ag --path-to-ignore ~/.ignore --follow $argv
end
