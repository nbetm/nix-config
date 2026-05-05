# Nord Deep

> An arctic, north-bluish color palette taken to deeper depths.

Nord Deep takes the original [Nord] palette deeper while keeping its relationships and pastel aesthetic intact.
Better contrast for accessibility, clearer UI hierarchy, more flexible theming.

## Philosophy

**Why deeper?** Modern screens benefit from more contrast without losing Nord's calm, muted character.
Nord Deep keeps what makes Nord work and adds:

- **Better accessibility:** improved contrast ratios for readability
- **Clearer hierarchy:** more distinct levels for complex UI layouts
- **Enhanced focus:** deeper background reduces visual noise

## Color Palettes

Four palettes, each with its own role.

### Polar Night

_Foundation colors for UI structure_

| Color | Name | Hex | Usage |
| -- | -- | -- | -- |
| <img src="assets/nord_base.png" height="16" width="16"/> | nord-base | `#212732` | Primary backgrounds (default bg) |
| <img src="assets/nord_surface.png" height="16" width="16"/> | nord-surface | `#2e3440` | Elevated surfaces |
| <img src="assets/nord_elevated.png" height="16" width="16"/> | nord-elevated | `#3b4252` | Interactive chrome, terminal: color0 |
| <img src="assets/nord_subtle.png" height="16" width="16"/> | nord-subtle | `#434c5e` | Subtle indicators, terminal: color8 |

### Snow Storm

_Text hierarchy from subtle to prominent_

| Color | Name | Hex | Usage |
| -- | -- | -- | -- |
| <img src="assets/nord_dim.png" height="16" width="16"/> | nord-dim | `#798094` | Disabled, comments |
| <img src="assets/nord_text.png" height="16" width="16"/> | nord-text | `#b8c5d1` | Primary content (default fg), terminal: color7 |
| <img src="assets/nord_bright.png" height="16" width="16"/> | nord-bright | `#d4dce6` | Emphasis, headings, terminal: color15 |

### Frost

_Structural syntax highlighting colors_

The Frost palette is **unchanged from original [Nord]** to keep the syntax aesthetic intact.

| Color | Name | Hex | Usage |
| -- | -- | -- | -- |
| <img src="assets/nord_aqua.png" height="16" width="16"/> | nord-aqua | `#8fbcbb` | Types, classes |
| <img src="assets/nord_cyan.png" height="16" width="16"/> | nord-cyan | `#88c0d0` | Functions, links, terminal: color6, color14 |
| <img src="assets/nord_blue.png" height="16" width="16"/> | nord-blue | `#81a1c1` | Keywords, operators, terminal: color4, color12 |
| <img src="assets/nord_navy.png" height="16" width="16"/> | nord-navy | `#5e81ac` | Characters, hints |

### Aurora

_Semantic syntax highlighting colors_

The Aurora palette is **unchanged from original [Nord]** for the same reason.

| Color | Name | Hex | Usage |
| -- | -- | -- | -- |
| <img src="assets/nord_red.png" height="16" width="16"/> | nord-red | `#bf616a` | Errors, deletions, terminal: color1, color9 |
| <img src="assets/nord_orange.png" height="16" width="16"/> | nord-orange | `#d08770` | Special highlights, TODO tags, etc |
| <img src="assets/nord_yellow.png" height="16" width="16"/> | nord-yellow | `#ebcb8b` | Warnings, regex, terminal: color3, color11 |
| <img src="assets/nord_green.png" height="16" width="16"/> | nord-green | `#a3be8c` | Strings, success, terminal: color2, color10 |
| <img src="assets/nord_magenta.png" height="16" width="16"/> | nord-magenta | `#b48ead` | Numbers, symbols, terminal: color5, color13 |

## Design Language

The colorscheme isn't just a palette: it encodes a small design vocabulary across UI surfaces.
New highlight groups should slot into one of these patterns rather than picking colors ad-hoc.

### Two-Tier Float Elevation

Floating / overlay windows split into two tiers based on the user's relationship to them:

- **Sunken** (`bg = base`): workspace surfaces you actively operate in.
  Filter / search popups, file-tree popups, key-hint popups.
  You navigate, search, decide inside these.
  Body, border, and title all paint on `base` so they read as extensions of the editor.
- **Raised** (`bg = surface`): transient feedback you didn't summon.
  Notifications, hover popups, completion popups, command-line peek, diagnostic float.
  The slight elevation signals "this came in" without shouting.

The cue is subtle (~13 RGB units between the two tiers) but unmistakable once your eye learns it.
Body, border, and title for any given surface should flip together to avoid a visible seam at the frame.

### Semantic Color Channels (popups)

Within popups, color carries meaning. Each channel has one role:

| Channel | Color | Role |
| -- | -- | -- |
| Active query / destination | `cyan` | titles, matched chars, prompt prefix, prompt caret |
| Navigational landmark | `magenta` | section headers, entries that descend into a submenu |
| Actionable key | `blue` | keys to press (key-hint popups, dashboard item prefixes) |
| Submode-entry key | `orange` | keys that put you in a sticky / repeating mode |
| Structural chrome | `subtle` | borders, separators |
| Faded / inactive | `dim` | unfocused pane title |
| Neutral typed input | `text` | what the user is typing (filter prompt body) |

### Three-Tier Row State

Rows in list surfaces (filter popups, completion popups) have a brightness hierarchy mapping to user intent:

- **Marked** (`bg = subtle`, brightest): items the user queued for action.
  Pull the eye most.
- **Current** (`bg = elevated`, softer): passive cursor position.
  Less emphasis since the user already knows where the cursor is.
- **Default** (no bg): ambient.

Marked > Current is deliberate.
Marked items represent *intent*; the cursor is just position.

### Selection by Background Only

Selected rows in list surfaces modulate `bg` only: fg falls through to the entry's content color.
Directories stay blue, files stay text-colored, kind labels stay aqua, *even when selected*.
The selection cue is positional (which row), not color-coded.

### Severity Reserved for Attention

Diagnostic colors (red, yellow, navy) appear only where they earn their visual weight: actual errors, warnings, hints.
Daily noise (INFO-level notifications, language-server progress) reads in neutral `text`.
Severity should be a signal, not a default.

### Focus Signaled by Fade

When multiple panes are visible (e.g., a multi-pane file explorer), the focused pane's title stays at baseline; *un*focused titles fade to `dim`.
Active stays put. The user's eye anchor doesn't move.
Inactive recedes.

### Structural Chrome Recedes

Borders, separators, and decorative dividers use `subtle` fg: present but quiet.
They never compete with content.

### Transparency and Layering

- Subtle highlights: use transparency like `#2e344080` (50% opacity) for active lines, wrap guides, indent guides.
- Fallback: blended result `#282e39` when transparency unavailable.
- Or use intermediate Polar Night colors (`surface`, `elevated`) for a middle ground.

## Terminal setup

```ini
background = #212732
foreground = #b8c5d1
selection_background = #3b4252
cursor = #b8c5d1
```

______________________________________________________________________

[nord]: https://www.nordtheme.com/docs/colors-and-palettes
