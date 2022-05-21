---- Custom
xplr.config.modes.custom = {
    ['git'] = require('git-mode').toplevel_mode,
    ['git add'] = require('git-mode').add_mode,
}
---- Builtin
------ Default
require 'default-mode'
------ Recover
require 'recover-mode'
------ Selection ops
require 'selection-ops-mode'
------ Create
require 'create-mode'
------ Create directory
require 'create-directory-mode'
------ Create file
require 'create-file-mode'
------ Number
require 'number-mode'
------ Go to
require 'goto-mode'
------ Rename
require 'rename-mode'
------ Delete
require 'delete-mode'
------ Action
require 'action-mode'
------ Quit
require 'quit-mode'
------ Search
require 'search-mode'
------ Filter
require 'filter-mode'
------ Relative path does match regex
require 'relative-path-does-match-regex'
------ Relative path does not match regex
require 'relative-path-does-not-match-regex'
------ Sort
require 'sort-mode'
------ Switch layout
require 'switch-layout-mode'
------ Goto path mode
require 'goto-path-mode'
