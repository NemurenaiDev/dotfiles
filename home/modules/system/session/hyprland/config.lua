hl.config({
    general = {
        gaps_in = 2.500000,
        gaps_out = 5,
        border_size = 1,

        layout = "dwindle",

        col = {
            active_border = { colors = { "rgb(94E2D5)", "rgb(F38BA8)", "rgb(F9E2AF)" }, angle = 270 },
        },
    },

    group = {
        col = {
            border_active = { colors = { "rgb(94E2D5)", "rgb(F38BA8)", "rgb(F9E2AF)" }, angle = 270 },
            border_inactive = { colors = { "rgb(94E2D5)", "rgb(F38BA8)", "rgb(F9E2AF)" }, angle = 270 },
            border_locked_active = { colors = { "rgb(94E2D5)", "rgb(F38BA8)", "rgb(F9E2AF)" }, angle = 270 },
            border_locked_inactive = { colors = { "rgb(94E2D5)", "rgb(F38BA8)", "rgb(F9E2AF)" }, angle = 270 },
        },

        groupbar = {
            scrolling = false,
            render_titles = false,

            col = {
                active = "rgb(94E2D5)",
                inactive = "rgb(585B70)",
                locked_active = "rgb(B4BEFE)",
                locked_inactive = "rgb(45475A)",
            },
        },
    },

    input = {
        repeat_rate = 50,
        repeat_delay = 300,
        numlock_by_default = false,
        accel_profile = "flat",
        sensitivity = 0,
        follow_mouse = 1,
        follow_mouse_threshold = 100,

        kb_layout = "us,ua,ru",
        kb_options = "fkeys:basic_13-24",

        touchpad = {
            clickfinger_behavior = true,
            disable_while_typing = true,
            tap_and_drag = true,
            natural_scroll = true,
            scroll_factor = 0.250000,
            drag_lock = 1,
        },
    },

    decoration = {
        rounding = 8,

        dim_special = 0.6,

        blur = {
            size = 2,
            passes = 2,
            enabled = false,
        },

        shadow = { enabled = false },
    },


    misc = {
        on_focus_under_fullscreen = 2,
        allow_session_lock_restore = 1,

        disable_hyprland_logo = true,
        disable_splash_rendering = true,

        key_press_enables_dpms = true,
        animate_manual_resizes = true,
        focus_on_activate = false,
        enable_swallow = true,
    },


    binds = {
        scroll_event_delay = 25,
        workspace_back_and_forth = false,
    },

    cursor = {
        default_monitor = nix.monitors.primary,
        sync_gsettings_theme = true,
    },

    ecosystem = {
        no_donation_nag = true,
        no_update_news = true,
    },

    dwindle = {
        preserve_split = true,
        smart_split = false,
    },

    scrolling = {
        column_width = 1,
        follow_min_visible = 0,
    },

    animations = { enabled = true },

    debug = { full_cm_proto = true },
})
