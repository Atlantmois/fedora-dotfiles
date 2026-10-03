Mellow Graphite Obsidian Lite
============================
User-level experimental Fcitx5 Classic UI theme based on Mellow Graphite dark 1.10.1.
Original installed theme is not modified.

Runtime background references:
  InputPanel/Background and Menu/Background -> panel.png
  InputPanel/Highlight and Menu/Highlight -> highlight.png
  Menu/CheckBox and Menu/SubMenu keep the original small SVG icons.

panel.svg and highlight.svg are recolored source assets. panel@2x.png and
highlight@2x.png are 62x62 pre-rendered masters. The runtime panel.png and
highlight.png are 31x31, downsampled from the 2x masters. Fcitx5 5.1.22
uses actual PNG pixel dimensions for nine-slice splitting. Keeping the runtime
PNG at 31x31 preserves the original 15px margins and 1px center; a 62x62
runtime PNG with unchanged margins would alter the corner geometry.

The theme inherits font, candidate direction, and DPI behavior from Classic UI.
No classicui.conf setting is changed by installing this theme.

v1 adjustments:
  Selected background: #8796A5; selected text: #14171D.
  InputPanel ContentMargin top/bottom: 7/6 -> 6/5.
  InputPanel TextMargin top/bottom: 6/7 -> 5/6.
  Font, candidate orientation, DPI, nine-slice margins, panel background,
  icons, and all other layout settings remain unchanged.
