import subprocess


def open_editor(filename):
    subprocess.run(
        [
            "st",
            "-g",
            "60x5",
            "-c",
            "Floaterm",
            "-e",
            "nvim",
            f"{filename}",
            "-c",
            "lua vim.g._no_noice = true",
            "-c",
            "lua vim.g._no_winbar = true",
            "-c",
            "lua vim.g._no_vimtex = true",
            "--cmd",
            "lua vim.g._no_cmp = true",
            "-c",
            "set cmdheight=1",
            "-c",
            "set ls=0",
        ]
    )


config = {"open_editor": open_editor}
