# Defined interactively
function code
set target_dir (xplr)
test -z "$target_dir"; and set target_dir "."
cd $target_dir
nvim
end
