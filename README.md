# Claude Code Best Practices Repository

This repository contains security best practices and standardized configurations for developing with Claude Code, combining GitHub-native security features with Claude Code runtime protections.

## Table of Contents
- [Overview](#overview)
- [GitHub Security Configurations](#github-security-configurations)
- [Claude Code Security Configurations](#claude-code-security-configurations)
- [Directory Structure](#directory-structure)
- [Usage Guidelines](#usage-guidelines)
- [Maintenance](#maintenance)

## Overview
This repo provides a secure foundation for projects using Claude Code, implementing:
- GitHub security best practices (Dependabot, CodeQL, security policy, community files)
- Claude Code runtime restrictions (filesystem, shell, environment, network permissions)
- Custom agents and commands for specialized tasks
- Comprehensive documentation of all applied standards

## GitHub Security Configurations

### `.github/SECURITY.md`
Defines the security policy, including vulnerability reporting procedures, supported versions, and scope.

### `.github/CODE_OF_CONDUCT.md`
Adopts the Contributor Covenant v2.1 to ensure a welcoming and inclusive community.

### `.github/CONTRIBUTING.md`
Provides contribution guidelines covering coding style (PEP 8, Prettier, Black), pull request process, and issue reporting.

### `.github/dependabot.yml`
Configures Dependabot for automatic dependency updates:
- Daily checks for GitHub Actions, Pip, and NPM ecosystems
- Allows direct and indirect dependency updates for Pip
- Ignores Django versions < 2.0

### `.github/workflows/codeql-analysis.yml`
Implements CodeQL security scanning:
- Triggers on push/pull_request to `main` and `develop` branches
- Weekly scheduled scans (Mondays at 12:00 UTC)
- Analyzes Python and JavaScript/TypeScript code
- Uploads results as SARIF files to the Security tab

## Claude Code Security Configurations

### `.claude/settings.json`
Implements granular permissions and security hooks:

**File System Permissions**
- Read access: entire project
- Write access: restricted to `src/`, `docs/`, `tests/`, `scripts/`
- Creation allowed in same directories as write
- Deletion limited to temporary/cache/logs directories
- Explicit denial of credential files (.env, *.key, *.pem, SSH keys, secrets, private data)
- Allow exceptions for standard configuration files (package.json, requirements.txt, tsconfig, etc.)

**Shell Permissions**
- Allow list: safe test, lint, and build commands (`npm test`, `pytest`, `ruff check`, `git status`, etc.)
- Deny list: dangerous commands including data destruction (`rm -rf /`, `mkfs`), network tools (`curl`, `wget`, `ssh`), privilege escalation (`sudo`, `su`), cloud providers (`aws`, `az`, `gcloud`), and containerization tools (`docker`, `kubectl`, `helm`, `terraform`)

**Environment Variable Restrictions**
- Allow: `NODE_ENV`, `PYTHONPATH`, `DJANGO_SETTINGS_MODULE`, `FLASK_ENV`, `FASTAPI_ENV`
- Deny: all variables containing credential indicators (AWS_*, GITHUB_TOKEN*, API_KEY*, SECRET*, PASSWORD*, etc.)

**Network Access Control**
- Allow: localhost-only communication
- Deny: all external network traffic by default
- Allow exceptions: GitHub API, npm registry, PyPI, and related services for legitimate package operations

**Security Hooks System**
- `preWrite`: Automatic formatting (Prettier, Black, Ruff) and secret detection
- `postWrite`: Whitespace checks and dependency vulnerability audits (npm audit, safety check)
- `preToolUse`: Tool usage audit logging and proactive secret writing prevention
- `postToolUse`: File modification logging for change tracking
- `onRequest`: Warnings when prompts contain sensitive terms

**Agent-Specific Permissions**
- `research-agent`: Broad read access for data collection, restricted write to research outputs
- `code-review-agent`: Full read access for analysis, restricted write to review outputs

**Sandbox Configuration**
- Read-only system directories (/etc, /usr, /boot, /lib, /lib64, /sbin, /bin)
- Project-restricted temporary directory

### `.claude/agents/research-agent.md`
Defines a specialized agent for information collection with capabilities for web search, OCR, and document analysis, including usage guidelines for ethical research practices.

### `.claude/agents/code-review-agent.md`
Defines a specialized agent focused on security-conscious code review, capable of detecting vulnerabilities, enforcing coding standards, and suggesting improvements.

### `.claude/commands/test-command.md`
Implements the `/test` command to execute project tests with coverage reporting and various options (unit, integration, watch modes).

### `.claude/commands/doc-command.md`
Implements the `/doc` command to generate technical documentation (API, architectural, user guide, contributing guidelines) from source code.

### `CLAUDE.md`
Provides project-specific instructions for Claude Code usage, including:
- Project overview and code structure
- Coding standards (PEP 8 with Black, ESLint+Prettier, Conventional Commits)
- Recommended workflow (feature branching, testing, code review, squash merge)
- Useful commands (`/test`, `/doc api`, `/research`, `/review`, `/security scan`)
- Security considerations (no credential commits, use GitHub Secrets, review generated code)

### `SECURITY_STANDARDS_AND_CONFIGURATIONS.md`
Comprehensive document explaining all applied standards (GitHub Security Best Practices, OWASP ASVS, Contributor Covenant, Semantic Versioning, Keep a Changelog), the purpose of each configuration file, supported events, verification methods, and maintenance guidelines.

## Directory Structure
```
claude-code-best-practices/
├── .github/
│   ├── SECURITY.md
│   ├── CODE_OF_CONDUCT.md
│   ├── CONTRIBUTING.md
│   ├── dependabot.yml
│   └── workflows/
│       └── codeql-analysis.yml
├── .claude/
│   ├── agents/
│   │   ├── research-agent.md
│   │   └── code-review-agent.md
│   ├── commands/
│   │   ├── test-command.md
│   │   └── doc-command.md
│   └── settings.json
├── CLAUDE.md
├── SECURITY_STANDARDS_AND_CONFIGURATIONS.md
└── README.md
```

## Usage Guidelines
1. **Clone the repository** to use as a template for new projects
2. **Review and adapt** the configurations in `.github/` and `.claude/` to your project's specific needs
3. **Use the Claude Code agents and commands** as defined:
   - `/test` - Run test suite
   - `/doc api` - Generate API documentation
   - `/research [topic]` - Initiate research on a topic
   - `/review` - Request code review from the specialized agent
   - `/security scan` - Execute quick security scan
4. **Follow the workflow** outlined in `CLAUDE.md`:
   - Create feature branches from `main`
   - Implement changes with adequate tests
   - Run full test suite with coverage
   - Request code review before merging
   - Use squash merge for clean history

## Maintenance
- Review the security policy (`SECURITY.md`) quarterly
- Monitor Dependabot alerts and update dependencies promptly
- Address CodeQL security alerts in a timely manner
- Keep contributing guidelines updated with development process changes
- Periodically review and adjust Claude Code permissions and hooks as the project evolves

## License
This repository is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
- GitHub Security Best Practices
- Contributor Covenant
- OWASP ASVS
- The Claude Code team for providing extensible security configurations
