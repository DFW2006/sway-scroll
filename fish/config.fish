# ============================================================
# YoRHa Terminal Interface :: Fish Shell Configuration
# Calibrated for warm-light kitty palette (bg: #bab5a1)
# "Everything that lives is designed to end."
# ============================================================

# ------------------------------------
# ENVIRONMENT
# ------------------------------------
set -x EDITOR nvim
set -x TERM xterm-256color


# ------------------------------------
# FISH COLORS — mapped to your kitty palette
#
# Your kitty theme:
#   bg:        #bab5a1  (warm sand)
#   fg:        #4b4b45  (dark olive-grey)
#   color0/8:  #4b4b45 / #5c5c56   (blacks)
#   color1/9:  #a35b5b / #b86b6b   (reds — errors/warnings)
#   color3/11: #968c6d / #afa382   (yellows — accents)
#   color5/13: #8e738a / #a3879f   (magentas — git/special)
#   color6/14: #6b8a82 / #7ea39a   (cyans — info)
#   color7/15: #d1cdb7 / #e8e4d0   (whites — bright)
# ------------------------------------

set -g fish_color_normal          4b4b45
set -g fish_color_command         2e2e28
set -g fish_color_keyword         4a5a6a
set -g fish_color_quote           6b8a82
set -g fish_color_redirection     968c6d
set -g fish_color_end             8e738a
set -g fish_color_error           a35b5b
set -g fish_color_param           5c5c56
set -g fish_color_comment         6b6b60
set -g fish_color_selection       --background=9d9987
set -g fish_color_search_match    --background=afa382
set -g fish_color_operator        968c6d
set -g fish_color_escape          a35b5b
set -g fish_color_autosuggestion  8a8678
set -g fish_color_cancel          a35b5b
set -g fish_pager_color_prefix    2e2e28
set -g fish_pager_color_completion 4b4b45
set -g fish_pager_color_description 9d9987
set -g fish_pager_color_progress  968c6d


# ------------------------------------
# GREETING — YoRHa Boot Sequence
# ------------------------------------
function fish_greeting
    set_color 5a5a52     # dark enough to read on sand bg
    echo ""
    echo "  ┌─────────────────────────────────────────┐"
    echo "  │     YoRHa Terminal Interface v3.0.1     │"
    echo "  │     Connecting to Bunker...             │"
    echo "  └─────────────────────────────────────────┘"
    set_color 4b4b45     # full fg for system lines
    echo ""
    echo "  [SYSTEM] Unit online. All processes nominal."
    echo "  [SYSTEM] Tactical data synchronized."
    set_color 6b6b60     # slightly muted for the flavor line
    echo "  [SYSTEM] \"Glory to Mankind.\""
    set_color normal
    echo ""
end


# ------------------------------------
# PROMPT — YoRHa Unit Style
# ------------------------------------
function fish_prompt
    set -l last_status $status
    set -l cwd (prompt_pwd --full-length-dirs 2 2>/dev/null; or basename (pwd))

    set -l git_branch ""
    if command -q git
        set -l branch (git branch --show-current 2>/dev/null)
        if test -n "$branch"
            set git_branch " ⌥$branch"
        end
    end

    echo ""

    set_color 5a5a52     # dark chrome — clearly visible on sand
    echo -n "  ╔══["
    set_color 2e2e28
    echo -n "2B"
    set_color 5a5a52
    echo -n "]══["
    set_color 4b4b45
    echo -n "$cwd"
    set_color 5a5a52
    echo -n "]"

    if test -n "$git_branch"
        set_color 5a5a52
        echo -n "══["
        set_color 8e738a
        echo -n "$git_branch"
        set_color 5a5a52
        echo -n "]"
    end

    if test $last_status -ne 0
        set_color a35b5b
        echo -n " [ERR:$last_status]"
    end

    echo ""

    set_color 5a5a52
    echo -n "  ╚══"
    set_color 2e2e28
    echo -n "► "
    set_color normal
end


# ------------------------------------
# RIGHT PROMPT — dim timestamp
# ------------------------------------
function fish_right_prompt
    set_color 8a8678
    echo -n (date "+%H:%M:%S")
    set_color normal
end


# ------------------------------------
# ALIASES
# ------------------------------------
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls --color=auto"
alias ll="ls -lah --color=auto"
alias la="ls -A --color=auto"
alias grep="grep --color=auto"
alias df="df -h"
alias du="du -h"
alias free="free -h"
alias ports="ss -tulpn"
alias neo="neo-matrix -D -a"
alias asciiquarium="asciiquarium -t"
alias pipes="pipes.sh -b -p 1 -t 1 -f 3"
alias pokemon="pokemon-colorscripts -r"
alias pkmn="pokemon-colorscripts -r"
alias tlp="tlp-stat"

# ------------------------------------
# FUNCTIONS
# ------------------------------------

function cd
    builtin cd $argv
    and begin
        set_color 6b6b60
        echo "  // navigating to: "(prompt_pwd)
        set_color normal
    end
end

function status_report
    set_color 5a5a52
    echo ""
    echo "  ┌──[ SYSTEM STATUS ]──────────────────────┐"
    echo "  │"
    set_color 4b4b45
    echo "  │  HOST   : "(hostname)
    echo "  │  KERNEL : "(uname -r)
    echo "  │  UPTIME : "(uptime -p 2>/dev/null; or uptime)
    echo "  │  SHELL  : Fish "(fish --version | string match -r '\d+\.\d+\.\d+')
    echo "  │"
    set_color 5a5a52
    echo "  └─────────────────────────────────────────┘"
    set_color normal
    echo ""
end

function extract
    if test -f $argv[1]
        switch $argv[1]
            case "*.tar.bz2";  tar xjf $argv[1]
            case "*.tar.gz";   tar xzf $argv[1]
            case "*.tar.xz";   tar xJf $argv[1]
            case "*.zip";      unzip $argv[1]
            case "*.gz";       gunzip $argv[1]
            case "*.7z";       7z x $argv[1]
            case "*"
                set_color a35b5b
                echo "  [ERR] Unknown archive format: $argv[1]"
                set_color normal
        end
    else
        set_color a35b5b
        echo "  [ERR] File not found: $argv[1]"
        set_color normal
    end
end

# ------------------------------------
# PATH
# ------------------------------------
fish_add_path ~/.local/bin
fish_add_path ~/bin
