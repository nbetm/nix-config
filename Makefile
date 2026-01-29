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
# Development
# ------------------------------------------------------------------------------

format: ## Format all nix files
	nix fmt

check: ## Check flake syntax and run flake checks
	nix flake check

ci: ## Run CI checks (format + flake check)
	nix fmt -- --ci
	nix flake check

repl: ## Start Nix REPL with this flake loaded
	nix repl --expr 'builtins.getFlake (toString ./.)'

search: ## Search nixpkgs for a package (usage: make search q=firefox)
	nix search nixpkgs $(q)

# ------------------------------------------------------------------------------
# Building & Testing
# ------------------------------------------------------------------------------

build: ## Build system configuration without switching (NixOS/Darwin only)
ifeq ($(OS_DISTRO),nixos)
	nixos-rebuild build --flake .
else ifeq ($(OS_DISTRO),darwin)
	darwin-rebuild build --flake .#atlas
else
	@echo "Build not supported on $(OS_DISTRO)."
	@exit 1
endif

diff: ## Show what would change on next deploy (NixOS only)
ifeq ($(OS_DISTRO),nixos)
	nixos-rebuild build --flake . && nvd diff /run/current-system result
else
	@echo "Diff only supported on NixOS (requires nvd)."
	@exit 1
endif

# ------------------------------------------------------------------------------
# Deployment
# ------------------------------------------------------------------------------

deploy: ## Apply system configuration changes (NixOS/Darwin only)
ifeq ($(OS_DISTRO),nixos)
	nixos-rebuild switch --flake . --sudo
else ifeq ($(OS_DISTRO),darwin)
	darwin-rebuild switch --flake .#atlas
else
	@echo "Deploy not supported on $(OS_DISTRO). Use 'make install' instead."
	@exit 1
endif

debug: ## Deploy with verbose output and trace for troubleshooting
ifeq ($(OS_DISTRO),nixos)
	nixos-rebuild switch --flake . --sudo --show-trace --verbose
else ifeq ($(OS_DISTRO),darwin)
	darwin-rebuild switch --flake .#atlas --show-trace --verbose
else
	@echo "Debug deploy not supported on $(OS_DISTRO)."
	@exit 1
endif

install: ## Install packages (deploy on NixOS/Darwin, profile add elsewhere)
ifeq ($(OS_DISTRO),nixos)
	$(MAKE) deploy
else ifeq ($(OS_DISTRO),darwin)
	$(MAKE) deploy
else
	nix profile add .#dev-tools --refresh
endif

rollback: ## Rollback to previous system generation (NixOS/Darwin only)
ifeq ($(OS_DISTRO),nixos)
	sudo nixos-rebuild switch --rollback
else ifeq ($(OS_DISTRO),darwin)
	darwin-rebuild switch --rollback
else
	@echo "Rollback not supported on $(OS_DISTRO). Use 'nix profile rollback' manually."
	@exit 1
endif

# ------------------------------------------------------------------------------
# Flake Inputs
# ------------------------------------------------------------------------------

update: ## Update all flake inputs
	nix flake update

upp: ## Update specific flake input (usage: make upp i=nixpkgs-unstable)
	nix flake update $(i)

upgrade: ## Update all flake inputs and deploy
ifeq ($(OS_DISTRO),nixos)
	nix flake update && $(MAKE) deploy
else ifeq ($(OS_DISTRO),darwin)
	nix flake update && $(MAKE) deploy
else
	nix flake update && nix profile upgrade '.*'
endif

# ------------------------------------------------------------------------------
# System Maintenance
# ------------------------------------------------------------------------------

generations: ## List system generations (NixOS/Darwin) or profile history
ifeq ($(OS_DISTRO),nixos)
	sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
else ifeq ($(OS_DISTRO),darwin)
	darwin-rebuild --list-generations
else
	nix profile history
endif

history: ## View detailed profile history
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
