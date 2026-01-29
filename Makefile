# System detection
OS_NAME ?= $(shell uname)
OS_DISTRO ?= $(shell \
    if [ -f /etc/nixos/configuration.nix ]; then echo "nixos"; \
    elif [ -f /etc/debian_version ]; then echo "debian"; \
    elif [ "$(OS_NAME)" = "Darwin" ]; then echo "darwin"; \
    else echo "unknown"; fi)

help: ## Show help for each of the Makefile recipes
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# ------------------------------------------------------------------------------
# System-specific commands
# ------------------------------------------------------------------------------

deploy: ## Apply system configuration changes (NixOS/Darwin only)
ifeq ($(OS_DISTRO),nixos)
	nixos-rebuild switch --flake . --use-remote-sudo
else ifeq ($(OS_DISTRO),darwin)
	darwin-rebuild switch --flake .#atlas
else
	@echo "Deploy not supported on $(OS_DISTRO). Use 'make install' instead."
	@exit 1
endif

debug: ## Deploy with verbose output and trace for troubleshooting (NixOS/Darwin only)
ifeq ($(OS_DISTRO),nixos)
	nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose
else ifeq ($(OS_DISTRO),darwin)
	darwin-rebuild switch --flake .#atlas --show-trace --verbose
else
	@echo "Debug deploy not supported on $(OS_DISTRO)."
	@exit 1
endif


# ------------------------------------------------------------------------------
# Universal commands
# ------------------------------------------------------------------------------

install: ## Install packages (deploy on NixOS/Darwin, profile add elsewhere)
ifeq ($(OS_DISTRO),nixos)
	$(MAKE) deploy
else ifeq ($(OS_DISTRO),darwin)
	$(MAKE) deploy
else
	nix profile add .#dev-tools --refresh
endif

upgrade: ## Update flake inputs and upgrade packages
ifeq ($(OS_DISTRO),nixos)
	nix flake update && $(MAKE) deploy
else ifeq ($(OS_DISTRO),darwin)
	nix flake update && $(MAKE) deploy
else
	nix flake update && nix profile upgrade '.*'
endif

rollback: ## Show rollback options (generations or profile history)
ifeq ($(OS_DISTRO),nixos)
	sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
else ifeq ($(OS_DISTRO),darwin)
	darwin-rebuild --list-generations
else
	nix profile history
endif

# ------------------------------------------------------------------------------
# Flake management
# ------------------------------------------------------------------------------

check: ## Check flake configuration syntax and validity
	nix flake check

format: ## Format all files with treefmt
	nix fmt

update: ## Update all flake inputs
	nix flake update

upp: ## Update specific flake input (usage: make upp i=nixpkgs-unstable)
	nix flake update $(i)

repl: ## Start Nix REPL with nixpkgs
	nix repl -f flake:nixpkgs

# ------------------------------------------------------------------------------
# System maintenance
# ------------------------------------------------------------------------------

history: ## View system generation or profile history
ifeq ($(OS_DISTRO),nixos)
	nix profile history --profile /nix/var/nix/profiles/system
else ifeq ($(OS_DISTRO),darwin)
	nix profile history --profile /nix/var/nix/profiles/system
else
	nix profile history
endif

clean: ## Remove generations older than 7 days
ifeq ($(OS_DISTRO),nixos)
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
else ifeq ($(OS_DISTRO),darwin)
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
else
	nix profile wipe-history --older-than 7d
endif

gc: ## Garbage collect unused nix store entries
ifeq ($(OS_DISTRO),nixos)
	sudo nix-collect-garbage --delete-old
else ifeq ($(OS_DISTRO),darwin)
	sudo nix-collect-garbage --delete-old
else
	nix-collect-garbage --delete-old
endif
