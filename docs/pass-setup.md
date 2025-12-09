# Pass (Password Store) Setup Guide

Complete guide for setting up, backing up, and restoring your password store across machines.

## Initial Setup (New Installation)

### 1. Generate GPG Key

```bash
# Generate a new GPG key
gpg --full-generate-key

# Recommended selections (Curve 25519 - modern, fast, secure):
# - Type: (9) ECC (sign and encrypt) *default*
# - Curve: (1) Curve 25519 *default*
# - Expiration: 0 (no expiration) or set one if you prefer
# - Name: Your Name
# - Email: your@email.com
# - Passphrase: Choose a strong one (you'll need this often)

# Alternative (RSA - maximum compatibility with old systems):
# - Type: (1) RSA and RSA
# - Size: 4096 bits
# - Rest: same as above
```

**Why Curve 25519?**

- Faster encryption/decryption (noticeable with frequent password access)
- Smaller keys (easier backups)
- Modern, secure algorithm
- Default in GPG 2.1+

Only use RSA if you need compatibility with very old systems (GPG < 2.1, pre-2014).

### 2. Get Your GPG Key ID

```bash
# List your keys
gpg --list-keys

# Output (Curve 25519):
# pub   ed25519 2025-12-09 [SC]
#       ABCD1234EFGH5678IJKL9012MNOP3456QRST7890  <-- Copy this
# uid           [ultimate] Your Name <your@email.com>
# sub   cv25519 2025-12-09 [E]

# Or for RSA:
# pub   rsa4096 2025-12-09 [SC]
#       ABCD1234EFGH5678IJKL9012MNOP3456QRST7890  <-- Copy this
# uid           [ultimate] Your Name <your@email.com>
```

### 3. Initialize Pass

```bash
# Using your email (easier to remember)
pass init your@email.com

# Or using the key ID
pass init ABCD1234EFGH5678IJKL9012MNOP3456QRST7890
```

This creates `~/.password-store/`

### 4. Set Up Git (for syncing across machines)

```bash
# Initialize git
pass git init

# Add remote repository (GitHub, GitLab, self-hosted, etc.)
pass git remote add origin git@github.com:yourusername/password-store.git

# Push initial commit
pass git push -u origin main
```

**Note:** Pass auto-commits every change, so you just need to push periodically.

## Daily Usage

### Adding Passwords

```bash
# Add password manually (prompts for input)
pass insert email/gmail

# Generate random password
pass generate social/github 20

# Generate without symbols (some sites don't allow them)
pass generate -n banking/chase 16

# Multi-line entries (password + other info)
pass insert -m work/vpn
# First line: password
# Additional lines: username, notes, etc.
```

### Retrieving Passwords

```bash
# Show password (prints to terminal)
pass email/gmail

# Copy to clipboard (auto-clears after 45 seconds)
pass -c email/gmail

# Show first line only (useful for multi-line entries)
pass email/gmail | head -1

# Show everything
pass email/gmail
```

### TOTP/2FA Codes

```bash
# Add TOTP secret
pass otp insert totp/github
# Paste the otpauth:// URI or secret key

# Get current TOTP code
pass otp totp/github

# Copy TOTP code to clipboard
pass otp -c totp/github
```

### Managing Passwords

```bash
# Edit password
pass edit email/gmail

# Remove password
pass rm email/gmail

# Move/rename password
pass mv old/path new/path

# Copy password entry
pass cp email/gmail email/gmail-backup

# List all passwords
pass

# Search for passwords
pass grep "github"
```

### Git Operations

```bash
# See password store history
pass git log

# Push changes to remote
pass git push

# Pull changes from remote
pass git pull

# Show changes
pass git diff
```

## Backup Procedures

### Backup GPG Key (CRITICAL - Do this once, keep it safe!)

```bash
# Export private key (KEEP THIS SECURE!)
gpg --export-secret-keys --armor your@email.com > gpg-private-key.asc

# Export public key
gpg --export --armor your@email.com > gpg-public-key.asc

# Export trust database (preserves key trust levels)
gpg --export-ownertrust > gpg-ownertrust.txt
```

### Backup Password Store

The password store is already backed up if you're using git. Just make sure to push regularly:

```bash
pass git push
```

Optional: Export password store as archive:

```bash
tar -czf password-store-backup-$(date +%Y%m%d).tar.gz ~/.password-store
```

## Restore on Another Machine

### 1. Install Pass (NixOS)

- pass/pass-wayland
- pass-otp
- pass-import
- pass-audit

### 2. Import GPG Key

```bash
# Import private key
gpg --import gpg-private-key.asc

# Import trust database
gpg --import-ownertrust < gpg-ownertrust.txt

# Set ultimate trust on your key
gpg --edit-key your@email.com
# Commands in GPG prompt:
#   trust
#   5 (ultimate trust)
#   quit

# Verify import
gpg --list-secret-keys
```

### 3. Clone Password Store

```bash
# Clone from git remote
git clone git@github.com:yourusername/password-store.git ~/.password-store

# Test it works
pass
pass email/gmail
```

### 4. Configure GPG Agent (if needed)

Already configured in NixOS, but if GPG agent isn't working:

```bash
# Restart GPG agent
gpgconf --kill gpg-agent
gpg-connect-agent /bye

# Test pinentry
echo "test" | gpg --sign --armor
```

## Advanced Usage

### Import from Other Password Managers

```bash
# Export from your current password manager (1Password, LastPass, etc.)
# Then import using pass-import

# Import from 1Password CSV
pass import 1password passwords.csv

# See all supported formats
pass import --list-importers
```

### Audit Passwords for Security

```bash
# Check for compromised passwords (Have I Been Pwned)
pass audit

# Audit specific password
pass audit email/gmail
```

### Multiple Password Stores

```bash
# Initialize separate store
PASSWORD_STORE_DIR=~/.password-store-work pass init work@email.com

# Use alternate store
PASSWORD_STORE_DIR=~/.password-store-work pass
```

## Troubleshooting

### GPG Agent Issues

```bash
# Restart GPG agent
gpgconf --kill gpg-agent
gpg-connect-agent /bye

# Check agent configuration
cat ~/.gnupg/gpg-agent.conf
```

## Quick Reference

```bash
# Common commands
pass                          # List all passwords
pass insert foo/bar           # Add password
pass generate foo/bar 20      # Generate password
pass -c foo/bar               # Copy to clipboard
pass edit foo/bar             # Edit password
pass rm foo/bar               # Remove password
pass mv old new               # Rename/move
pass grep "search"            # Search passwords

# TOTP
pass otp insert totp/foo      # Add TOTP
pass otp totp/foo             # Get TOTP code

# Git
pass git push                 # Push changes
pass git pull                 # Pull changes
pass git log                  # View history

# Utilities
pass audit                    # Check for leaks
pass import <manager> <file>  # Import passwords
```

## Resources

- [Pass homepage](https://www.passwordstore.org/)
- [GPG guide](https://www.gnupg.org/gph/en/manual/c14.html)
