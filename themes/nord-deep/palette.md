# Nord Deep

> An arctic, north-bluish color palette taken to deeper depths.

[Nord], but deeper.
The backgrounds go darker for clearer layering.
Two new sub-palettes (Washes and Deeps) add channel-tinted row backgrounds and saturated pill backgrounds.
Frost and Aurora keep Nord's hues, with `red` and `navy` nudged brighter for legible contrast on the deeper canvas; the syntax aesthetic you came to Nord for stays intact.

## Contents

1. [Palette](#palette)
   - [Background Colors (palette1)](#background-colors-palette1)
   - [Foreground Colors (palette2)](#foreground-colors-palette2)
1. [Highlights](#highlights)
1. [Design Language](#design-language)
   - [Surfaces](#surfaces)
   - [Channels](#channels)

## Palette

Two sub-palettes: `palette1` for backgrounds, `palette2` for foregrounds.
Each groups by purpose.
The 5 Aurora channels plus 2 Frost channels (`blue`, `navy`) carry matching `wash_*` and `deep_*` slots. `aqua` and `cyan` skip the derived tiers since their primary uses (types, functions, live cue) don't fit row backgrounds or pills.
Several wash and deep variants are kept for symmetry even though their primary uses are still being defined.

### Background Colors (palette1)

<sub>polar night: neutral surfaces</sub>\
![#212732][212732]![#2e3440][2e3440]![#3b4252][3b4252]![#434c5e][434c5e]

<sub>washes: channel-tinted row backgrounds</sub>\
![#39313c][39313c]![#323138][323138]![#313439][313439]![#2d353a][2d353a]![#30313e][30313e]![#2b3340][2b3340]![#2b3443][2b3443]

<sub>deeps: saturated pill backgrounds</sub>\
![#82515b][82515b]![#785751][785751]![#665f50][665f50]![#556356][556356]![#6a5a70][6a5a70]![#4e6075][4e6075]![#4b617d][4b617d]

### Foreground Colors (palette2)

<sub>default</sub>\
![#b8c5d1][b8c5d1]

<sub>emphasis</sub>\
![#d4dce6][d4dce6]

<sub>greys: de-emphasis foregrounds</sub>\
![#5d6478][5d6478]![#798094][798094]![#929aae][929aae]

<sub>frost: structural syntax</sub>\
![#8fbcbb][8fbcbb]![#88c0d0][88c0d0]![#81a1c1][81a1c1]![#6c8eb8][6c8eb8]

<sub>aurora: semantic syntax</sub>\
![#c97078][c97078]![#d08770][d08770]![#ebcb8b][ebcb8b]![#a3be8c][a3be8c]![#b48ead][b48ead]

## Highlights

| | Hex | Identifier | Usages |
|-----------------------|-----------|-----------------|--------|
| ![#212732][hl_bg] | `#212732` | `bg` | Default background, active tab |
| ![#2e3440][hl_bg1] | `#2e3440` | `bg1` | Floats (pickers, file-tree, key-hint, notifications, hover, completion, diagnostics), status / tab / message bars, inactive tabs |
| ![#3b4252][hl_bg2] | `#3b4252` | `bg2` | Visual selection, current row in canvas windows (quickfix); terminal `color0` |
| ![#434c5e][hl_bg3] | `#434c5e` | `bg3` | Borders, separators, split dividers; current / marked row inside `bg1` floats (picker, completion, file-tree) |
| ![#39313c][hl_wred] | `#39313c` | `wash_red` | Diff minus row, error-row background |
| ![#323138][hl_wora] | `#323138` | `wash_orange` | Committed-state row, sticky / repeating-mode row background |
| ![#313439][hl_wyel] | `#313439` | `wash_yellow` | Search-hit row, warning-row background |
| ![#2d353a][hl_wgre] | `#2d353a` | `wash_green` | Diff plus row, success-row background |
| ![#30313e][hl_wmag] | `#30313e` | `wash_magenta` | Section-header row, mark-row background |
| ![#2b3340][hl_wblu] | `#2b3340` | `wash_blue` | Reserved for plugin-driven full-row selection bands (see palette intro) |
| ![#2b3443][hl_wnav] | `#2b3443` | `wash_navy` | _TBD_ |
| ![#82515b][hl_dred] | `#82515b` | `deep_red` | Error pill, "PR closed", deletion badge |
| ![#785751][hl_dora] | `#785751` | `deep_orange` | Pending-state pill, draft badge |
| ![#665f50][hl_dyel] | `#665f50` | `deep_yellow` | Warning pill, review-requested badge |
| ![#556356][hl_dgre] | `#556356` | `deep_green` | Success pill, "PR merged" |
| ![#6a5a70][hl_dmag] | `#6a5a70` | `deep_magenta` | Section pill, label badge |
| ![#4e6075][hl_dblu] | `#4e6075` | `deep_blue` | Key-chord chip, "PR open", info pill |
| ![#4b617d][hl_dnav] | `#4b617d` | `deep_navy` | _TBD_ |
| ![#b8c5d1][hl_fg] | `#b8c5d1` | `fg` | Default foreground, body content on `bg` / `bg1` / `wash_*`; terminal `color7` |
| ![#d4dce6][hl_fgb] | `#d4dce6` | `fg_bright` | Emphasis, headings, body fg on `bg2` and `deep_*`; terminal `color15` |
| ![#5d6478][hl_g0] | `#5d6478` | `grey0` | Ghost text (zsh / fish autosuggest), line numbers, fold columns, inline blame, unfocused glyphs; terminal `color8` |
| ![#798094][hl_g1] | `#798094` | `grey1` | Comments, disabled |
| ![#929aae][hl_g2] | `#929aae` | `grey2` | Cursor line number, recessed labels still meant to read |
| ![#8fbcbb][hl_aqua] | `#8fbcbb` | `aqua` | Types, classes, structural identifiers |
| ![#88c0d0][hl_cyan] | `#88c0d0` | `cyan` | Functions, links, live cue (active prompt prefix, active surface title); terminal `color6`, `color14` |
| ![#81a1c1][hl_blue] | `#81a1c1` | `blue` | Keywords, operators, punctuation, list bullets, action targets (key-hints, dashboard prefixes, TODO markers); terminal `color4`, `color12` |
| ![#6c8eb8][hl_navy] | `#6c8eb8` | `navy` | Built-ins (booleans, `nil` / `None` / `undefined`), preprocessor / pragmas, LSP hints, NOTE markers, blockquotes |
| ![#c97078][hl_red] | `#c97078` | `red` | Errors, deletions, FIXME markers; terminal `color1`, `color9` |
| ![#d08770][hl_orange] | `#d08770` | `orange` | Committed / paired result (resolved match, bracket pair, sticky / repeating keys) |
| ![#ebcb8b][hl_yellow] | `#ebcb8b` | `yellow` | Warnings, regex, escapes, character literals, search hits already on screen; terminal `color3`, `color11` |
| ![#a3be8c][hl_green] | `#a3be8c` | `green` | Strings, success indicators; terminal `color2`, `color10` |
| ![#b48ead][hl_magenta]| `#b48ead` | `magenta` | Numbers, symbols, navigational landmarks (section headers, submenu entries); terminal `color5`, `color13` |

## Design Language

The colorscheme follows a small set of rules so new highlight groups fit a pattern instead of picking colors ad-hoc.
Most placements come down to two questions: what surface the group sits on (its background) and what it means (its channel).

### Surfaces

**Floats.**
Every float sits on `bg1` so it reads as a distinct surface lifted off the buffer, not a continuation of it.
Pickers, file-tree, and key-hint popups take a `cyan` title accent (the live cue: you're driving them); notifications, hover, completion, and diagnostic floats use a neutral `fg` title.
Same bg, different title channel.

**Tab and status strips.**
Status, tab, and message bars are chrome, so they sit at `bg1` like floats: one step off the canvas.
That reserves `bg2` and `bg3` for selection.
The active tab is the one exception that moves on the bg axis: it drops to `bg` to merge with its buffer, while inactive tabs stay at `bg1`.

**Row state in lists.**
The cursor row takes the selection lift, with body fg promoted to `fg_bright` so contrast stays high.
Marked rows add bold and a prefix glyph: they outrank the cursor by weight, not by a darker bg.
Default rows have no bg.
When the cursor sits inside a content wash (error row, diff line, search-hit row), the row keeps its `wash_<channel>` bg and shows the cursor through bold fg or a leading glyph.
The wash owns the bg axis, the cursor wins on weight or glyph: the same move as a marked row.

**Selection lifts two steps off its surface.**
Selected rows change `bg` only; fg falls through to the entry's own color, so directories stay blue, files stay `fg`, kind labels stay aqua even when selected.
Selection is positional, not color-coded.
The lift is always two steps, measured from whatever sits underneath: `bg → bg2` over the buffer canvas (Visual, single-row cursor, quickfix line), `bg1 → bg3` inside a float (picker current / marked row, completion menu, file-tree cursor).
It stays on the neutral ladder rather than a channel tint, so it reads as an active operation on anything it lands on: canvas, floats, content washes alike.

**Row content state.**
When a row *is* something (diff line, error, warning, search hit), the row gets a `wash_<channel>` bg matching its meaning.
Body fg stays `fg`; the leading glyph or a left sidebar stripe carries the channel color, not the bg alone.
Content washes are independent of cursor and marked state and stack on top: `bg = wash_<channel>` with marked's bold and glyph above.
A wash gives ambient tonal weight; the channel glyph does the channel work, so washes read in isolation rather than side by side.
Diff hunks are the exception where adjacency matters, and the `+` / `-` markers (green / red) disambiguate `wash_green` from `wash_red`.

**Diagnostic messages ride on washes.**
Diagnostic rows render body in `fg` over `wash_<severity>`, with the channel color as a leading glyph and (optionally) a left sidebar stripe.
Red and navy as fg on canvas only clear AA for short bold tokens, so a full message gets its severity from the wash and glyph.

**Pills and badges.**
Short labels with their own background (state pills, key-chord chips, PR bubbles) sit on `deep_<channel>` with `fg_bright`.
The deep bg is a tonal container for legibility; a leading channel-color glyph or dot carries the channel signal.
The glyph is required for channels whose deeps go nearly neutral at AA (yellow especially), and used on all pills for consistency.

**Transparency for soft highlights.**
The editor-buffer active line (`CursorLine`), wrap guides, and indent guides use a soft overlay: `#2e344080` (50% over canvas), or `#282e39` as the non-transparent fallback (a 50/50 blend of `bg` and `bg1`, not its own slot).
Kept soft so syntax colors stay legible underneath, unlike picker rows, which take the stronger `bg3` because their content is denser and less colorful.

### Channels

Each color has a role beyond syntax. Pick by intent.

| Channel | Color | Role |
|---------------------------|-----------|------|
| Live / as-you-type cue | `cyan` | Active prompt prefix, active surface title, match under cursor |
| Committed / paired result | `orange` | Resolved match, bracket pair, sticky / repeating keys |
| Passive attention | `yellow` | On-screen search hits, warnings, change indicators |
| Navigational landmark | `magenta` | Section headers, submenu entries |
| Action target / structural | `blue` | Keys to press (key-hint popups, dashboard prefixes), TODO markers, punctuation, list bullets |
| Secondary information / built-ins | `navy` | Booleans, builtin constants (`nil` / `None` / `undefined`), preprocessor / pragmas, LSP hints, NOTE markers, blockquotes |
| Type / structure noun | `aqua` | Type names, structural identifiers |
| Structural trim | `bg3` | Borders, separators |
| Faded / inactive | `grey1` | Comments, disabled, unfocused titles and statuslines |
| Neutral typed input | `fg` | Filter prompt body, caret |

The match-state trio: `cyan` is live (typing now), `orange` is committed (resolved match, paired bracket, sticky key), `yellow` is the middle (already on screen, not urgent).

**Severity follows a ladder.**
Diagnostic colors earn their weight: `red` for errors, `yellow` for warnings, `navy` for LSP hints.
Comment markers map to channels by intent: FIXME = `red` (must fix), WARN = `yellow` (be careful), TODO = `blue` (deferred action), NOTE = `navy` (info).
INFO-level noise (notifications, LSP progress) reads in neutral `fg`.

**Focus signaled by fade.**
When several panes share the screen, the focused pane keeps its title and statusline at full strength while the others fade to `grey1`.
Focus rides the fg, not the bg: that is why the status bars all sit at `bg1` instead of lifting the active one.
Active stays put, inactive fades.

**Borders stay quiet.**
Borders, separators, and dividers use `bg3` as fg: present but quiet.
The only text that ever sits *on* `bg3` is a float's selection row, where fg promotes to `fg_bright` and recessed labels use `grey2` (not `grey1`) to clear AA.

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
[30313e]: https://fakeimg.ryd.tools/96/30313e/b8c5d1/?text=%2330313e&font=noto&font_size=12 "wash_magenta - #30313e"
[39313c]: https://fakeimg.ryd.tools/96/39313c/b8c5d1/?text=%2339313c&font=noto&font_size=12 "wash_red - #39313c"
[3b4252]: https://fakeimg.ryd.tools/96/3b4252/b8c5d1/?text=%233b4252&font=noto&font_size=12 "bg2 - #3b4252"
[434c5e]: https://fakeimg.ryd.tools/96/434c5e/d4dce6/?text=%23434c5e&font=noto&font_size=12 "bg3 - #434c5e"
[4b617d]: https://fakeimg.ryd.tools/96/4b617d/d4dce6/?text=%234b617d&font=noto&font_size=12 "deep_navy - #4b617d"
[4e6075]: https://fakeimg.ryd.tools/96/4e6075/d4dce6/?text=%234e6075&font=noto&font_size=12 "deep_blue - #4e6075"
[5d6478]: https://fakeimg.ryd.tools/96/5d6478/212732/?text=%235d6478&font=noto&font_size=12 "grey0 - #5d6478"
[665f50]: https://fakeimg.ryd.tools/96/665f50/d4dce6/?text=%23665f50&font=noto&font_size=12 "deep_yellow - #665f50"
[6a5a70]: https://fakeimg.ryd.tools/96/6a5a70/d4dce6/?text=%236a5a70&font=noto&font_size=12 "deep_magenta - #6a5a70"
[6c8eb8]: https://fakeimg.ryd.tools/96/6c8eb8/212732/?text=%236c8eb8&font=noto&font_size=12 "navy - #6c8eb8"
[81a1c1]: https://fakeimg.ryd.tools/96/81a1c1/212732/?text=%2381a1c1&font=noto&font_size=12 "blue - #81a1c1"
[82515b]: https://fakeimg.ryd.tools/96/82515b/d4dce6/?text=%2382515b&font=noto&font_size=12 "deep_red - #82515b"
[88c0d0]: https://fakeimg.ryd.tools/96/88c0d0/212732/?text=%2388c0d0&font=noto&font_size=12 "cyan - #88c0d0"
[8fbcbb]: https://fakeimg.ryd.tools/96/8fbcbb/212732/?text=%238fbcbb&font=noto&font_size=12 "aqua - #8fbcbb"
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
[hl_magenta]: https://fakeimg.ryd.tools/48/b48ead/b48ead/ "magenta - #b48ead"
[hl_navy]: https://fakeimg.ryd.tools/48/6c8eb8/6c8eb8/ "navy - #6c8eb8"
[hl_orange]: https://fakeimg.ryd.tools/48/d08770/d08770/ "orange - #d08770"
[hl_red]: https://fakeimg.ryd.tools/48/c97078/c97078/ "red - #c97078"
[hl_wblu]: https://fakeimg.ryd.tools/48/2b3340/2b3340/ "wash_blue - #2b3340"
[hl_wgre]: https://fakeimg.ryd.tools/48/2d353a/2d353a/ "wash_green - #2d353a"
[hl_wmag]: https://fakeimg.ryd.tools/48/30313e/30313e/ "wash_magenta - #30313e"
[hl_wnav]: https://fakeimg.ryd.tools/48/2b3443/2b3443/ "wash_navy - #2b3443"
[hl_wora]: https://fakeimg.ryd.tools/48/323138/323138/ "wash_orange - #323138"
[hl_wred]: https://fakeimg.ryd.tools/48/39313c/39313c/ "wash_red - #39313c"
[hl_wyel]: https://fakeimg.ryd.tools/48/313439/313439/ "wash_yellow - #313439"
[hl_yellow]: https://fakeimg.ryd.tools/48/ebcb8b/ebcb8b/ "yellow - #ebcb8b"
[nord]: https://www.nordtheme.com/
