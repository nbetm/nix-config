# Nord Deep

> An arctic, north-bluish color palette taken to deeper depths.

[Nord], but deeper.
The backgrounds go darker for clearer layering.
Two new sub-palettes (Washes and Deeps) add channel-tinted row backgrounds and saturated pill backgrounds.
Frost and Aurora stay identical to upstream Nord, so the syntax highlighting you came to Nord for is untouched.

## Contents

1. [Palette](#palette)
   - [Background Colors (palette1)](#background-colors-palette1)
   - [Foreground Colors (palette2)](#foreground-colors-palette2)
1. [Highlights](#highlights)
1. [Design Language](#design-language)
   - [Surfaces](#surfaces)
   - [Channels](#channels)
   - [Other Rules](#other-rules)

## Palette

Two sub-palettes: `palette1` for backgrounds, `palette2` for foregrounds.
Each groups by purpose.
Numeric naming for backgrounds (`bg`, `bg1`, `bg2`, `bg3`) and greys (`grey0`, `grey1`, `grey2`) follows the everforest / gruvbox convention: it scales freely if more tiers are needed and avoids semantic lock-in if a tier's role evolves.
The 5 Aurora channels plus 3 Frost channels (`blue`, `navy`, `indigo`) carry matching `wash_*` and `deep_*` slots. `aqua` and `cyan` skip the derived tiers since their primary uses (types, functions, live cue) don't fit row backgrounds or pills. Several wash and deep variants are kept for symmetry even though their primary uses are still being defined.

### Background Colors (palette1)

<sub>polar night: neutral surfaces</sub>\
![#212732][212732]![#2e3440][2e3440]![#3b4252][3b4252]![#434c5e][434c5e]

<sub>washes: channel-tinted row backgrounds</sub>\
![#39313c][39313c]![#323138][323138]![#313439][313439]![#2d353a][2d353a]![#30313e][30313e]![#2b3340][2b3340]![#2b3443][2b3443]![#2e3445][2e3445]

<sub>deeps: saturated pill backgrounds</sub>\
![#82515b][82515b]![#785751][785751]![#665f50][665f50]![#556356][556356]![#6a5a70][6a5a70]![#4e6075][4e6075]![#4b617d][4b617d]![#5a5d83][5a5d83]

### Foreground Colors (palette2)

<sub>default</sub>\
![#b8c5d1][b8c5d1]

<sub>emphasis</sub>\
![#d4dce6][d4dce6]

<sub>greys: de-emphasis foregrounds</sub>\
![#5d6478][5d6478]![#798094][798094]![#929aae][929aae]

<sub>frost: structural syntax</sub>\
![#8fbcbb][8fbcbb]![#88c0d0][88c0d0]![#81a1c1][81a1c1]![#6c8eb8][6c8eb8]![#9090d0][9090d0]

<sub>aurora: semantic syntax</sub>\
![#c97078][c97078]![#d08770][d08770]![#ebcb8b][ebcb8b]![#a3be8c][a3be8c]![#b48ead][b48ead]

## Highlights

| | Hex | Identifier | Usages |
|-----------------------|-----------|-----------------|--------|
| ![#212732][hl_bg] | `#212732` | `bg` | Default background, sunken floats (filter/file-tree/key-hint popups), active tab |
| ![#2e3440][hl_bg1] | `#2e3440` | `bg1` | Raised floats (notifications, hover popups, completion, diagnostic float), inactive tabs and statusline sections |
| ![#3b4252][hl_bg2] | `#3b4252` | `bg2` | Marked / current row, active statusline, Visual selection; terminal `color0` |
| ![#434c5e][hl_bg3] | `#434c5e` | `bg3` | Borders, separators, split dividers, structural trim (no text role) |
| ![#39313c][hl_wred] | `#39313c` | `wash_red` | Diff minus row, error-row background |
| ![#323138][hl_wora] | `#323138` | `wash_orange` | Committed-state row, sticky / repeating-mode row background |
| ![#313439][hl_wyel] | `#313439` | `wash_yellow` | Search-hit row, warning-row background |
| ![#2d353a][hl_wgre] | `#2d353a` | `wash_green` | Diff plus row, success-row background |
| ![#30313e][hl_wmag] | `#30313e` | `wash_magenta` | Section-header row, mark-row background |
| ![#2b3340][hl_wblu] | `#2b3340` | `wash_blue` | Reserved for plugin-driven full-row selection bands (see palette intro) |
| ![#2b3443][hl_wnav] | `#2b3443` | `wash_navy` | _TBD_ |
| ![#2e3445][hl_wind] | `#2e3445` | `wash_indigo` | _TBD_ |
| ![#82515b][hl_dred] | `#82515b` | `deep_red` | Error pill, "PR closed", deletion badge |
| ![#785751][hl_dora] | `#785751` | `deep_orange` | Pending-state pill, draft badge |
| ![#665f50][hl_dyel] | `#665f50` | `deep_yellow` | Warning pill, review-requested badge |
| ![#556356][hl_dgre] | `#556356` | `deep_green` | Success pill, "PR merged" |
| ![#6a5a70][hl_dmag] | `#6a5a70` | `deep_magenta` | Section pill, label badge |
| ![#4e6075][hl_dblu] | `#4e6075` | `deep_blue` | Key-chord chip, "PR open", info pill |
| ![#4b617d][hl_dnav] | `#4b617d` | `deep_navy` | _TBD_ |
| ![#5a5d83][hl_dind] | `#5a5d83` | `deep_indigo` | _TBD_ |
| ![#b8c5d1][hl_fg] | `#b8c5d1` | `fg` | Default foreground, body content on `bg` / `bg1` / `wash_*`; terminal `color7` |
| ![#d4dce6][hl_fgb] | `#d4dce6` | `fg_bright` | Emphasis, headings, body fg on `bg2` and `deep_*`; terminal `color15` |
| ![#5d6478][hl_g0] | `#5d6478` | `grey0` | Ghost text (zsh / fish autosuggest), line numbers, fold columns, unfocused glyphs; terminal `color8` |
| ![#798094][hl_g1] | `#798094` | `grey1` | Comments, disabled, inline blame |
| ![#929aae][hl_g2] | `#929aae` | `grey2` | Cursor line number, recessed labels still meant to read |
| ![#8fbcbb][hl_aqua] | `#8fbcbb` | `aqua` | Types, classes, structural identifiers |
| ![#88c0d0][hl_cyan] | `#88c0d0` | `cyan` | Functions, links, live cue (active prompt prefix, active surface title); terminal `color6`, `color14` |
| ![#81a1c1][hl_blue] | `#81a1c1` | `blue` | Keywords, operators, action targets (key-hints, dashboard prefixes, TODO markers); terminal `color4`, `color12` |
| ![#6c8eb8][hl_navy] | `#6c8eb8` | `navy` | Characters, LSP hints, NOTE markers, blockquotes |
| ![#9090d0][hl_indigo] | `#9090d0` | `indigo` | Value literals (booleans, builtin constants like `nil` / `None` / `undefined`), list bullets, Terraform identifiers |
| ![#c97078][hl_red] | `#c97078` | `red` | Errors, deletions, FIXME markers; terminal `color1`, `color9` |
| ![#d08770][hl_orange] | `#d08770` | `orange` | Committed / paired result (resolved match, bracket pair, sticky / repeating keys) |
| ![#ebcb8b][hl_yellow] | `#ebcb8b` | `yellow` | Warnings, regex, search hits already on screen; terminal `color3`, `color11` |
| ![#a3be8c][hl_green] | `#a3be8c` | `green` | Strings, success indicators; terminal `color2`, `color10` |
| ![#b48ead][hl_magenta]| `#b48ead` | `magenta` | Numbers, symbols, navigational landmarks (section headers, submenu entries); terminal `color5`, `color13` |

## Design Language

The colorscheme follows a small set of rules for picking colors.
New highlight groups should fit one of the patterns below rather than picking colors ad-hoc.

### Surfaces

**Floats.**
Every float sits on `bg1` so it reads as a distinct surface lifted off the buffer, not a continuation of it.
Pickers, file-tree, and key-hint popups take a `cyan` title accent (the live cue: you're driving them); notifications, hover, completion, and diagnostic floats use a neutral `fg` title.
Same bg, different title channel.

**Tab and status strips.**
The active tab drops to `bg` so it merges with its buffer; inactive tabs sit at `bg1`.
The active statusline section rises to `bg2` so it reads as a layer above the buffer; inactive sections fall to `bg1`.

**Row state in lists.**
Cursor row: `bg = bg2`, body fg promotes to `fg_bright` so contrast stays at AAA on `bg2`.
Marked rows add bold and a prefix glyph; marked outranks current by weight, not by bg shade.
Default rows have no bg.
When the cursor sits inside a content wash (error row, diff line, search-hit row), the row keeps `wash_<channel>` as bg; the cursor position shows via bold body fg or a leading cursor glyph.
The wash wins on the bg axis, the cursor wins on weight or glyph (the same pattern as marked rows within `bg2`).

**Row content state.**
When a row *is* something (diff line, error, warning, search hit), the row gets a `wash_<channel>` bg matching its meaning.
Body fg stays `fg`; the leading glyph or a left sidebar stripe carries the channel color, not the bg alone.
Content washes are independent of cursor and marked state and stack on top: `bg = wash_<channel>` with marked's bold and glyph above.
A wash gives ambient tonal weight; the channel glyph does the channel work, so washes read in isolation rather than side by side.
Diff hunks are the exception where adjacency matters, and the `+` / `-` markers (green / red) disambiguate `wash_green` from `wash_red`.

**Pills and badges.**
Short labels with their own background (state pills, key-chord chips, PR bubbles) sit on `deep_<channel>` with `fg_bright`.
The deep bg is a tonal container for legibility (~4.5:1 AA); a leading channel-color glyph or dot carries the channel signal.
The glyph is required for channels whose deeps go nearly neutral at AA (yellow especially), and used on all pills for consistency.

### Channels

Each color has a role beyond syntax. Pick by intent.

| Channel | Color | Role |
|---------------------------|-----------|------|
| Live / as-you-type cue | `cyan` | Active prompt prefix, active surface title, match under cursor |
| Committed / paired result | `orange` | Resolved match, bracket pair, sticky / repeating keys |
| Passive attention | `yellow` | On-screen search hits, warnings, change indicators |
| Navigational landmark | `magenta` | Section headers, submenu entries |
| Action target | `blue` | Keys to press (key-hint popups, dashboard prefixes), TODO markers |
| Secondary information | `navy` | LSP hints, NOTE markers, blockquotes |
| Value literal / structural marker | `indigo` | Booleans, builtin constants (`nil` / `None` / `undefined`), list bullets, Terraform identifiers |
| Type / structure noun | `aqua` | Type names, structural identifiers |
| Structural trim | `bg3` | Borders, separators (no text role) |
| Faded / inactive | `grey1` | Comments, disabled, unfocused titles |
| Neutral typed input | `fg` | Filter prompt body, caret |

The match-state trio: `cyan` is live (typing now), `orange` is committed (resolved match, paired bracket, sticky key), `yellow` is the middle (already on screen, not urgent).

### Other Rules

**Selection changes bg only.**
Selected rows change `bg`; fg falls through to the entry's content color.
Directories stay blue, files stay `fg`, kind labels stay aqua even when selected.
Selection is positional, not color-coded.
Visual-mode multi-select and single-row cursor highlight both lift to `bg2`.
Selection is an active operation, not passive content state, so it stays distinguishable against any surface: canvas, `bg1` floats, and content washes alike.
A channel-tinted `wash_blue` would sit at the same low-luminance tier as the washes it overlaps, so Visual uses `bg2` instead.

**Severity follows a ladder.**
Diagnostic colors earn their weight: `red` for errors, `yellow` for warnings, `navy` for LSP hints.
Comment markers map to channels by intent: FIXME = `red` (must fix), WARN = `yellow` (be careful), TODO = `blue` (deferred action), NOTE = `navy` (info).
INFO-level noise (notifications, LSP progress) reads in neutral `fg`.

**Diagnostic messages use washes, not coloured body fg.**
Diagnostic rows render body in `fg` over `wash_<severity>`, with the channel color applied as a leading glyph and (optionally) a left sidebar stripe.
Aurora red and Frost navy as foregrounds on canvas reach ~4.4:1, which clears AA-Large for bold short syntax tokens but not the 4.5:1 normal-text AA threshold for prose-length messages.

**Focus signaled by fade.**
When multiple panes are visible, the focused pane's title stays at baseline; *un*focused titles fade to `grey1`.
Active stays put, inactive fades.

**Borders stay quiet.**
Borders, separators, and dividers use `bg3` fg: present but quiet.
`bg3` is *not* a body-text colour; rendering text on it falls to AA at best.

**Transparency for soft highlights.**
The editor-buffer active line (`CursorLine`), wrap guides, and indent guides use a soft overlay: `#2e344080` (50% over canvas), or `#282e39` as the non-transparent fallback (a 50/50 blend of `bg` and `bg1`, not its own slot).
Kept soft so syntax colors stay legible underneath, unlike picker rows, which take the stronger `bg2` because their content is denser and less colorful.

______________________________________________________________________

<!-- palette1: polar night -->

<!-- palette1: washes -->

<!-- palette1: deeps -->

<!-- palette2: foregrounds -->

<!-- palette2: frost -->

<!-- palette2: aurora -->

<!-- highlights descriptions (solid swatches, no text) -->

[212732]: https://fakeimg.ryd.tools/96/212732/b8c5d1/?text=%23212732&font=noto&font_size=12 "bg - #212732"
[313439]: https://fakeimg.ryd.tools/96/313439/b8c5d1/?text=%23313439&font=noto&font_size=12 "wash_yellow - #313439"
[323138]: https://fakeimg.ryd.tools/96/323138/b8c5d1/?text=%23323138&font=noto&font_size=12 "wash_orange - #323138"
[556356]: https://fakeimg.ryd.tools/96/556356/d4dce6/?text=%23556356&font=noto&font_size=12 "deep_green - #556356"
[785751]: https://fakeimg.ryd.tools/96/785751/d4dce6/?text=%23785751&font=noto&font_size=12 "deep_orange - #785751"
[798094]: https://fakeimg.ryd.tools/96/798094/212732/?text=%23798094&font=noto&font_size=12 "grey1 - #798094"
[2b3340]: https://fakeimg.ryd.tools/96/2b3340/b8c5d1/?text=%232b3340&font=noto&font_size=12 "wash_blue - #2b3340"
[2b3443]: https://fakeimg.ryd.tools/96/2b3443/b8c5d1/?text=%232b3443&font=noto&font_size=12 "wash_navy - #2b3443"
[2d353a]: https://fakeimg.ryd.tools/96/2d353a/b8c5d1/?text=%232d353a&font=noto&font_size=12 "wash_green - #2d353a"
[2e3440]: https://fakeimg.ryd.tools/96/2e3440/b8c5d1/?text=%232e3440&font=noto&font_size=12 "bg1 - #2e3440"
[2e3445]: https://fakeimg.ryd.tools/96/2e3445/b8c5d1/?text=%232e3445&font=noto&font_size=12 "wash_indigo - #2e3445"
[30313e]: https://fakeimg.ryd.tools/96/30313e/b8c5d1/?text=%2330313e&font=noto&font_size=12 "wash_magenta - #30313e"
[39313c]: https://fakeimg.ryd.tools/96/39313c/b8c5d1/?text=%2339313c&font=noto&font_size=12 "wash_red - #39313c"
[3b4252]: https://fakeimg.ryd.tools/96/3b4252/b8c5d1/?text=%233b4252&font=noto&font_size=12 "bg2 - #3b4252"
[434c5e]: https://fakeimg.ryd.tools/96/434c5e/d4dce6/?text=%23434c5e&font=noto&font_size=12 "bg3 - #434c5e"
[4b617d]: https://fakeimg.ryd.tools/96/4b617d/d4dce6/?text=%234b617d&font=noto&font_size=12 "deep_navy - #4b617d"
[4e6075]: https://fakeimg.ryd.tools/96/4e6075/d4dce6/?text=%234e6075&font=noto&font_size=12 "deep_blue - #4e6075"
[5a5d83]: https://fakeimg.ryd.tools/96/5a5d83/d4dce6/?text=%235a5d83&font=noto&font_size=12 "deep_indigo - #5a5d83"
[5d6478]: https://fakeimg.ryd.tools/96/5d6478/212732/?text=%235d6478&font=noto&font_size=12 "grey0 - #5d6478"
[665f50]: https://fakeimg.ryd.tools/96/665f50/d4dce6/?text=%23665f50&font=noto&font_size=12 "deep_yellow - #665f50"
[6a5a70]: https://fakeimg.ryd.tools/96/6a5a70/d4dce6/?text=%236a5a70&font=noto&font_size=12 "deep_magenta - #6a5a70"
[6c8eb8]: https://fakeimg.ryd.tools/96/6c8eb8/212732/?text=%236c8eb8&font=noto&font_size=12 "navy - #6c8eb8"
[81a1c1]: https://fakeimg.ryd.tools/96/81a1c1/212732/?text=%2381a1c1&font=noto&font_size=12 "blue - #81a1c1"
[82515b]: https://fakeimg.ryd.tools/96/82515b/d4dce6/?text=%2382515b&font=noto&font_size=12 "deep_red - #82515b"
[88c0d0]: https://fakeimg.ryd.tools/96/88c0d0/212732/?text=%2388c0d0&font=noto&font_size=12 "cyan - #88c0d0"
[8fbcbb]: https://fakeimg.ryd.tools/96/8fbcbb/212732/?text=%238fbcbb&font=noto&font_size=12 "aqua - #8fbcbb"
[9090d0]: https://fakeimg.ryd.tools/96/9090d0/212732/?text=%239090d0&font=noto&font_size=12 "indigo - #9090d0"
[929aae]: https://fakeimg.ryd.tools/96/929aae/212732/?text=%23929aae&font=noto&font_size=12 "grey2 - #929aae"
[a3be8c]: https://fakeimg.ryd.tools/96/a3be8c/212732/?text=%23a3be8c&font=noto&font_size=12 "green - #a3be8c"
[b48ead]: https://fakeimg.ryd.tools/96/b48ead/212732/?text=%23b48ead&font=noto&font_size=12 "magenta - #b48ead"
[b8c5d1]: https://fakeimg.ryd.tools/96/b8c5d1/212732/?text=%23b8c5d1&font=noto&font_size=12 "fg - #b8c5d1"
[c97078]: https://fakeimg.ryd.tools/96/c97078/212732/?text=%23c97078&font=noto&font_size=12 "red - #c97078"
[d08770]: https://fakeimg.ryd.tools/96/d08770/212732/?text=%23d08770&font=noto&font_size=12 "orange - #d08770"
[d4dce6]: https://fakeimg.ryd.tools/96/d4dce6/212732/?text=%23d4dce6&font=noto&font_size=12 "fg_bright - #d4dce6"
[ebcb8b]: https://fakeimg.ryd.tools/96/ebcb8b/212732/?text=%23ebcb8b&font=noto&font_size=12 "yellow - #ebcb8b"
[hl_aqua]: https://fakeimg.ryd.tools/48/8fbcbb/8fbcbb/ "aqua - #8fbcbb"
[hl_bg]: https://fakeimg.ryd.tools/48/212732/212732/ "bg - #212732"
[hl_bg1]: https://fakeimg.ryd.tools/48/2e3440/2e3440/ "bg1 - #2e3440"
[hl_bg2]: https://fakeimg.ryd.tools/48/3b4252/3b4252/ "bg2 - #3b4252"
[hl_bg3]: https://fakeimg.ryd.tools/48/434c5e/434c5e/ "bg3 - #434c5e"
[hl_blue]: https://fakeimg.ryd.tools/48/81a1c1/81a1c1/ "blue - #81a1c1"
[hl_cyan]: https://fakeimg.ryd.tools/48/88c0d0/88c0d0/ "cyan - #88c0d0"
[hl_dblu]: https://fakeimg.ryd.tools/48/4e6075/4e6075/ "deep_blue - #4e6075"
[hl_dgre]: https://fakeimg.ryd.tools/48/556356/556356/ "deep_green - #556356"
[hl_dind]: https://fakeimg.ryd.tools/48/5a5d83/5a5d83/ "deep_indigo - #5a5d83"
[hl_dmag]: https://fakeimg.ryd.tools/48/6a5a70/6a5a70/ "deep_magenta - #6a5a70"
[hl_dnav]: https://fakeimg.ryd.tools/48/4b617d/4b617d/ "deep_navy - #4b617d"
[hl_dora]: https://fakeimg.ryd.tools/48/785751/785751/ "deep_orange - #785751"
[hl_dred]: https://fakeimg.ryd.tools/48/82515b/82515b/ "deep_red - #82515b"
[hl_dyel]: https://fakeimg.ryd.tools/48/665f50/665f50/ "deep_yellow - #665f50"
[hl_fg]: https://fakeimg.ryd.tools/48/b8c5d1/b8c5d1/ "fg - #b8c5d1"
[hl_fgb]: https://fakeimg.ryd.tools/48/d4dce6/d4dce6/ "fg_bright - #d4dce6"
[hl_g0]: https://fakeimg.ryd.tools/48/5d6478/5d6478/ "grey0 - #5d6478"
[hl_g1]: https://fakeimg.ryd.tools/48/798094/798094/ "grey1 - #798094"
[hl_g2]: https://fakeimg.ryd.tools/48/929aae/929aae/ "grey2 - #929aae"
[hl_green]: https://fakeimg.ryd.tools/48/a3be8c/a3be8c/ "green - #a3be8c"
[hl_indigo]: https://fakeimg.ryd.tools/48/9090d0/9090d0/ "indigo - #9090d0"
[hl_magenta]: https://fakeimg.ryd.tools/48/b48ead/b48ead/ "magenta - #b48ead"
[hl_navy]: https://fakeimg.ryd.tools/48/6c8eb8/6c8eb8/ "navy - #6c8eb8"
[hl_orange]: https://fakeimg.ryd.tools/48/d08770/d08770/ "orange - #d08770"
[hl_red]: https://fakeimg.ryd.tools/48/c97078/c97078/ "red - #c97078"
[hl_wblu]: https://fakeimg.ryd.tools/48/2b3340/2b3340/ "wash_blue - #2b3340"
[hl_wgre]: https://fakeimg.ryd.tools/48/2d353a/2d353a/ "wash_green - #2d353a"
[hl_wind]: https://fakeimg.ryd.tools/48/2e3445/2e3445/ "wash_indigo - #2e3445"
[hl_wmag]: https://fakeimg.ryd.tools/48/30313e/30313e/ "wash_magenta - #30313e"
[hl_wnav]: https://fakeimg.ryd.tools/48/2b3443/2b3443/ "wash_navy - #2b3443"
[hl_wora]: https://fakeimg.ryd.tools/48/323138/323138/ "wash_orange - #323138"
[hl_wred]: https://fakeimg.ryd.tools/48/39313c/39313c/ "wash_red - #39313c"
[hl_wyel]: https://fakeimg.ryd.tools/48/313439/313439/ "wash_yellow - #313439"
[hl_yellow]: https://fakeimg.ryd.tools/48/ebcb8b/ebcb8b/ "yellow - #ebcb8b"
[nord]: https://www.nordtheme.com/
