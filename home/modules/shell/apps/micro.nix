{
  programs.micro = {
    enable = true;

    settings = {
      autoindent = true;
      eofnewline = true;
      rmtrailingws = true;
      smartpaste = true;

      cursorline = true;
      scrollmargin = 8;
      pageoverlap = 2;

      ruler = true;
      relativeruler = false;
      colorcolumn = 100;

      ignorecase = true;
      incsearch = true;
      hlsearch = true;

      diff = true;
      diffgutter = true;

      clipboard = "terminal";

      saveundo = true;
      savecursor = true;
      savehistory = true;

      tabstospaces = true;
      tabsize = 4;
    };
  };

  home.file.".config/micro/bindings.json".force = true;
  home.file.".config/micro/bindings.json".text = ''
    {
      "Esc": "Escape",
      "Esc": "RemoveAllMultiCursors",

      "Ctrl-Alt-Down": "SpawnMultiCursorDown",
      "Ctrl-Alt-Up": "SpawnMultiCursorUp",
      "Ctrl-d": "SpawnMultiCursor",

      "Shift-Alt-Down": "DuplicateLine",
      "Shift-Alt-Up": "DuplicateLine",

      "Ctrl-a": "SelectAll",
      "Ctrl-l": "SelectLine",
      "Ctrl-w": "WordLeft",
      "Ctrl-Shift-Right": "SelectWordRight",
      "Ctrl-Shift-Left": "SelectWordLeft",

      "Ctrl-c": "Copy",
      "Ctrl-x": "Cut",
      "Ctrl-v": "Paste",

      "Ctrl-z": "Undo",
      "Ctrl-y": "Redo",

      "Ctrl-Enter": "InsertNewline",
    }
  '';
}
