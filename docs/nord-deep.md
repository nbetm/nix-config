# Nord Deep

> An arctic, north-bluish color palette taken to deeper depths.

[Nord], but deeper.
Polar Night and Snow Storm get reworked: deeper darks, more contrast, clearer hierarchy.
Frost and Aurora stay exactly as they were, so the syntax aesthetic you came to Nord for is untouched.

## Color Palettes

Four palettes, four roles.

### Polar Night

The dark side of the theme.
Four shades, darkest to brightest: canvas, surface, elevated, trim.
The rest of the doc keeps coming back to them.

| Color | Name | Hex | Usage |
| -- | -- | -- | -- |
| <img src="assets/nord_base.png" height="16" width="16"/> | nord-base | `#212732` | Canvas / primary background (default bg) |
| <img src="assets/nord_surface.png" height="16" width="16"/> | nord-surface | `#2e3440` | Slightly raised surfaces (transient popups) |
| <img src="assets/nord_elevated.png" height="16" width="16"/> | nord-elevated | `#3b4252` | More lift (current row, active statusline), terminal: color0 |
| <img src="assets/nord_chrome.png" height="16" width="16"/> | nord-chrome | `#434c5e` | Borders, separators, structural trim, terminal: color8 |

### Snow Storm

Text, from quiet to loud.

| Color | Name | Hex | Usage |
| -- | -- | -- | -- |
| <img src="assets/nord_dim.png" height="16" width="16"/> | nord-dim | `#798094` | Disabled, comments |
| <img src="assets/nord_text.png" height="16" width="16"/> | nord-text | `#b8c5d1` | Primary content (default fg), terminal: color7 |
| <img src="assets/nord_bright.png" height="16" width="16"/> | nord-bright | `#d4dce6` | Emphasis, headings, terminal: color15 |

### Frost

Structural syntax. Untouched from original [Nord] to keep the aesthetic intact.

| Color | Name | Hex | Usage |
| -- | -- | -- | -- |
| <img src="assets/nord_aqua.png" height="16" width="16"/> | nord-aqua | `#8fbcbb` | Types, classes |
| <img src="assets/nord_cyan.png" height="16" width="16"/> | nord-cyan | `#88c0d0` | Functions, links, terminal: color6, color14 |
| <img src="assets/nord_blue.png" height="16" width="16"/> | nord-blue | `#81a1c1` | Keywords, operators, terminal: color4, color12 |
| <img src="assets/nord_navy.png" height="16" width="16"/> | nord-navy | `#5e81ac` | Characters, hints |

### Aurora

Semantic syntax. Also untouched from original [Nord], same reason.

| Color | Name | Hex | Usage |
| -- | -- | -- | -- |
| <img src="assets/nord_red.png" height="16" width="16"/> | nord-red | `#bf616a` | Errors, deletions, terminal: color1, color9 |
| <img src="assets/nord_orange.png" height="16" width="16"/> | nord-orange | `#d08770` | Special highlights, TODO tags, etc |
| <img src="assets/nord_yellow.png" height="16" width="16"/> | nord-yellow | `#ebcb8b` | Warnings, regex, terminal: color3, color11 |
| <img src="assets/nord_green.png" height="16" width="16"/> | nord-green | `#a3be8c` | Strings, success, terminal: color2, color10 |
| <img src="assets/nord_magenta.png" height="16" width="16"/> | nord-magenta | `#b48ead` | Numbers, symbols, terminal: color5, color13 |

## Design Language

The colorscheme isn't just a palette: it encodes a small design vocabulary.
New highlight groups should slot into one of these patterns instead of picking colors ad-hoc.

### Surfaces

Three rules for backgrounds: floating windows, the tab and status strips, and rows in lists.

**Float tiers.**
Floating windows split into two tiers based on your relationship to them.
Sunken (`bg = base`) for surfaces you actively operate in: filter popups, file-tree popups, key-hint popups.
You navigate, search, decide inside these.
Body, border, and title all paint on `base` so they read as extensions of the editor.
Raised (`bg = surface`) for transient feedback you didn't summon: notifications, hover popups, completion popups, command-line peek, diagnostic float.
The slight elevation signals "this came in" without shouting.
The cue is subtle (~13 RGB units between the two tiers) but unmistakable once your eye learns it.
Body, border, and title for any given surface should flip together to avoid a visible seam at the frame.

**Tab and status strips.**
Both strips run along the canvas edges, but they sit at different elevations on purpose.
The active tab drops to `base`: tabs represent buffers, so the current tab visually merges with the buffer it shows (same logic as Sunken floats).
Inactive tabs sit at `surface`, halfway up.
The active statusline section rises to `elevated`: the statusline is meta-info, not a workspace surface, so it reads as a distinct layer rather than buffer content.
Inactive sections fall to `surface`.
Same shades, opposite directions: tabs sink toward their buffer, statusline rises above it.

**Row state in lists.**
Rows have a hierarchy keyed to your intent.
Marked rows (`bg = elevated`, bold + prefix glyph) are items you queued for action: they pull the eye via typographic weight.
Current (`bg = elevated`, regular weight) is the passive cursor position: same lift, less emphasis.
Default has no bg.
Marked outranks Current by weight, not by bg shade.
That keeps `chrome` reserved as a pure fg color for structural trim, no second job.

### Channels

Color carries meaning beyond syntax.
Each channel has one role; new highlight groups pick a channel by intent rather than picking a color ad-hoc.

| Channel | Color | Role |
| -- | -- | -- |
| Live / as-you-type cue | `cyan` | active prompt prefix, title of the active surface, the match under the typing cursor |
| Committed / paired result | `orange` | the resolved match (next jump target), bracket pair, sticky / repeating-mode keys |
| Passive attention | `yellow` | search hits already on screen, warning severity, change indicators, TODO-class tags |
| Navigational landmark | `magenta` | section headers, entries that descend into a submenu |
| Actionable key | `blue` | keys to press (key-hint popups, dashboard prefixes) |
| Secondary information | `navy` | hint severity, ambient annotations (inline blame, blockquotes, NOTE markers) |
| Type / structure noun | `aqua` | type names, code spans, structural identifiers (Frost sibling to cyan, mostly syntax) |
| Structural trim | `chrome` | borders, separators, visible polar accents |
| Faded / inactive | `dim` | unfocused titles, recessed labels |
| Neutral typed input | `text` | what the user is typing (filter prompt body, caret) |

Cyan and orange are the pairing to know.
Cyan is live (you're typing right now); orange is committed (resolved match, paired bracket, sticky key).
Yellow sits between them: already on screen, but not urgent.

### Other Rules

The smaller conventions that keep the theme consistent.

**Selection modulates bg only.**
Selected rows in list surfaces change `bg` only: fg falls through to the entry's content color.
Directories stay blue, files stay text-colored, kind labels stay aqua, *even when selected*.
The selection cue is positional (which row), not color-coded.

**Severity is for actual attention.**
Diagnostic colors (red, yellow, navy) appear only where they earn their weight: real errors, warnings, hints.
Daily noise (INFO-level notifications, language-server progress) reads in neutral `text`.
Severity should be a signal, not a default.

**Focus signaled by fade.**
When multiple panes are visible (e.g., a multi-pane file explorer), the focused pane's title stays at baseline.
*Un*focused titles fade to `dim`.
Active stays put, inactive fades.
Your eye anchor doesn't move.

**Borders stay quiet.**
Borders, separators, and decorative dividers use `chrome` fg: present but quiet.
They never compete with content.

**Transparency for soft highlights.**
For soft highlights (active lines, wrap guides, indent guides), use transparency like `#2e344080` (50% opacity).
When transparency isn't available, the blended result `#282e39` is the fallback.
For a middle ground, use one of the intermediate Polar Night colors (`surface`, `elevated`).

## Terminal Setup

The minimum to get Nord Deep into your terminal:

```ini
background = #212732
foreground = #b8c5d1
selection_background = #3b4252
cursor = #b8c5d1
```

______________________________________________________________________

[nord]: https://www.nordtheme.com/
