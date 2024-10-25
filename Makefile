# Makefile for Next.js project with pnpm, shadcn, ESLint, Git, react-email, Stripe, Prisma, and pnpx

# Variables
PNPM := pnpm
PNPX := pnpx
NEXT := $(PNPM) next
ESLINT := $(PNPM) eslint
GIT := git
REACT_EMAIL := $(PNPM) react-email
PRISMA := $(PNPM) prisma

# Default target
.PHONY: all
all: install build

# Install dependencies
.PHONY: install
install:
	$(PNPM) install

# Install specific package
.PHONY: add
add:
	$(PNPM) add $(filter-out $@,$(MAKECMDGOALS))

# Install development dependency
.PHONY: add-dev
add-dev:
	$(PNPM) add -D $(filter-out $@,$(MAKECMDGOALS))

# Uninstall a package
.PHONY: remove
remove:
	$(PNPM) remove $(filter-out $@,$(MAKECMDGOALS))

# Run a command with pnpx
.PHONY: pnx
pnx:
	$(PNPX) $(filter-out $@,$(MAKECMDGOALS))

# Prisma commands
.PHONY: prisma-init
prisma-init:
	$(PRISMA) init

.PHONY: prisma-generate
prisma-generate:
	$(PRISMA) generate

.PHONY: prisma-migrate
prisma-migrate:
	$(PRISMA) migrate dev --name $(filter-out $@,$(MAKECMDGOALS))

.PHONY: prisma-seed
prisma-seed:
	$(PRISMA) db seed

.PHONY: prisma-studio
prisma-studio:
	$(PRISMA) studio

# Run development server
.PHONY: dev
dev:
	$(NEXT) dev

# Build the project
.PHONY: build
build:
	$(NEXT) build

# Start production server
.PHONY: start
start:
	$(NEXT) start

# Run ESLint
.PHONY: lint
lint:
	$(ESLINT) .

# Fix ESLint issues
.PHONY: lint-fix
lint-fix:
	$(ESLINT) . --fix

# Run tests
.PHONY: test
test:
	$(PNPM) test

# Add shadcn component
.PHONY: shadcn
shadcn:
	$(PNPM) shadcn-ui add $(filter-out $@,$(MAKECMDGOALS))

# Git commands
.PHONY: git-status
git-status:
	$(GIT) status

.PHONY: git-add
git-add:
	$(GIT) add .

.PHONY: git-commit
git-commit:
	$(GIT) commit -m "$(filter-out $@,$(MAKECMDGOALS))"

.PHONY: git-push
git-push:
	$(GIT) push

# React Email commands
.PHONY: email-dev
email-dev:
	$(REACT_EMAIL) dev

.PHONY: email-export
email-export:
	$(REACT_EMAIL) export

# Stripe CLI commands (assuming Stripe CLI is installed)
.PHONY: stripe-listen
stripe-listen:
	stripe listen --forward-to localhost:3000/api/webhooks

.PHONY: stripe-trigger
stripe-trigger:
	stripe trigger $(filter-out $@,$(MAKECMDGOALS))

# Clean build artifacts
.PHONY: clean
clean:
	rm -rf .next out

# Catch-all target for passing arguments
%:
	@:

# Help command
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make install         - Install dependencies"
	@echo "  make add             - Add a package (e.g., make add <package-name>)"
	@echo "  make add-dev         - Add a devDependency (e.g., make add-dev <package-name>)"
	@echo "  make remove          - Uninstall a package (e.g., make remove <package-name>)"
	@echo "  make pnx             - Run a command with pnpx (e.g., make pnx <command>)"
	@echo "  make prisma-init     - Initialize Prisma"
	@echo "  make prisma-generate - Generate Prisma client"
	@echo "  make prisma-migrate  - Run Prisma migrations (e.g., make prisma-migrate <migration-name>)"
	@echo "  make prisma-seed     - Seed the database with Prisma"
	@echo "  make prisma-studio   - Open Prisma Studio"
	@echo "  make dev             - Start development server"
	@echo "  make build           - Build the project"
	@echo "  make start           - Start production server"
	@echo "  make lint            - Run ESLint"
	@echo "  make lint-fix        - Fix ESLint issues"
	@echo "  make test            - Run tests"
	@echo "  make shadcn          - Add shadcn component (e.g., make shadcn button)"
	@echo "  make git-status      - Show Git status"
	@echo "  make git-add         - Stage all changes"
	@echo "  make git-commit      - Commit changes (e.g., make git-commit 'Commit message')"
	@echo "  make git-push        - Push changes to remote"
	@echo "  make email-dev       - Start react-email development server"
	@echo "  make email-export    - Export react-email templates"
	@echo "  make stripe-listen   - Start Stripe webhook listener"
	@echo "  make stripe-trigger  - Trigger Stripe event (e.g., make stripe-trigger payment_intent.succeeded)"
	@echo "  make clean           - Clean build artifacts"
	@echo "  make help            - Show this help message"
