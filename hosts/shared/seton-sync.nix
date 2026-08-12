# Periodic `seton sync` for the Obsidian vault.
#
# Imported only by hosts holding a vault checkout (aura, andromeda).
{ ... }:

{
  systemd.user.services.seton-sync = {
    description = "Sync the Obsidian vault with its remote";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "%h/.local/bin/seton sync";

      # 2 is seton's "retry later" (offline, or the Obsidian plugin holds the
      # flock), which the next tick resolves. That leaves 1, "needs a human", as
      # the only code reaching `systemctl --user --failed`.
      SuccessExitStatus = "0 2";

      # NixOS's default PATH for user units omits jj and flock.
      #
      # No SSH_AUTH_SOCK on purpose: the account key needs a passphrase, so an
      # agent-based unit could never run unattended on headless andromeda. This
      # requires the vault remote to use the `github-seton` alias and its
      # passphrase-less deploy key; without that, every run fails as a silent 2.
      Environment = "PATH=/run/current-system/sw/bin";
    };
  };

  systemd.user.timers.seton-sync = {
    description = "Sync the Obsidian vault every 15 minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:0/15";
      # Catch up after the host was suspended or off, rather than skipping.
      Persistent = true;
      RandomizedDelaySec = "30s";
    };
  };

  # No After=network-online.target: offline already yields a self-healing exit 2,
  # so ordering against network state would add a hangable dependency for free.
}
