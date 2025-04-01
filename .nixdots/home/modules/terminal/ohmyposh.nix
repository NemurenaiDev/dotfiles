{
  home.file.".config/ohmyposh.toml".text = ''
    console_title_template = '{{ .Shell }} in {{ .Folder }}'
    version = 3
    final_space = true

    [secondary_prompt]
      template = '❯❯ '
      foreground = 'magenta'
      background = 'transparent'

    [transient_prompt]
      template = '❯ '
      background = 'transparent'
      foreground_templates = ['{{if gt .Code 0}}red{{end}}', '{{if eq .Code 0}}magenta{{end}}']

    [[blocks]]
      type = 'prompt'
      alignment = 'left'
      newline = true

      [[blocks.segments]]
        style = 'plain'
        template = '{{ .Path }} '
        foreground = 'blue'
        background = 'transparent'
        type = 'path'

        [blocks.segments.properties]
          style = 'full'

      [[blocks.segments]]
        style = 'plain'
        template = '{{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>'
        foreground = 'p:grey'
        background = 'transparent'
        type = 'git'

        [blocks.segments.properties]
          branch_icon = ' '
          cherry_pick_icon = ' '
          commit_icon = ' '
          fetch_status = false
          fetch_upstream_icon = false
          merge_icon = ' '
          no_commits_icon = ' '
          rebase_icon = ' '
          revert_icon = ' '
          tag_icon = ' '

    [[blocks]]
      type = 'rprompt'
      overflow = 'hidden'

      [[blocks.segments]]
        style = 'plain'
        template = '{{ .FormattedMs }}'
        foreground = 'yellow'
        background = 'transparent'
        type = 'executiontime'

        [blocks.segments.properties]
          threshold = 5000

    [[blocks]]
      type = 'prompt'
      alignment = 'left'

      [[blocks.segments]]
        style = 'plain'
        template = '❯'
        background = 'transparent'
        type = 'text'
        foreground_templates = ['{{if gt .Code 0}}red{{end}}', '{{if eq .Code 0}}magenta{{end}}']
  '';
}
