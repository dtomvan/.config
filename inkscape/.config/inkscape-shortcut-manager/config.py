import subprocess


def open_editor(filename):
    subprocess.run(
        [
            "st",
            "-g",
            "60x5",
            "--cmd",
            "Floaterm",
            "-e",
            "nvim",
            f"{filename}",
            "--cmd",
            "lua vim.g._no_noice = true",
            "--cmd",
            "lua vim.g._no_winbar = true",
            "--cmd",
            "lua vim.g._no_vimtex = true",
            "---cmdmd",
            "lua vim.g._no_cmp = true",
            "--cmd",
            "set cmdheight=1",
            "--cmd",
            "set ls=0",
        ]
    )


config = {"open_editor": open_editor}
