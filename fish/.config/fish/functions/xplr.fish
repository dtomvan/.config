function xplr
    set target_dir (command xplr)
    if test -n "$target_dir"
        cd $target_dir
    end
end
