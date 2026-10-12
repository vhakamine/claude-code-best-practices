# Project Instructions for Claude Code

This file contains specific guidance for using Claude Code in this repository.

## Project Overview
System for monitoring and analyzing clandestine dinner influencers, focusing on:
- Public data source collection
- ETL processing
- Optical character recognition (OCR) in documents
- RESTful API for information querying

## Code Structure
- `/src` - Main source code
- `/tests` - Automated tests
- `/docs` - Technical documentation
- `/scripts` - Utilities and maintenance scripts

## Coding Standards
- Python: PEP 8 with Black formatting
- JavaScript/TypeScript: ESLint + Prettier
- Documentation: Markdown with explicit links
- Commits: Conventional Commits

## Recommended Workflow
1. Create branch from `main`: `git checkout -b feature/feature-name`
2. Implement changes with adequate tests
3. Run full test suite: `/test --coverage`
4. Request code review: `/review` or pull request
5. After approval, merge via squash merge

## Useful Commands
- `/test` - Executes tests
- `/doc api` - Generates API documentation
- `/research [tópico]` - Inicia pesquisa sobre tópico específico
- `/review` - Solicita revisão de código do agente especializado
- `/security scan` - Executa varredura de segurança rápida

## Considerações de Segurança
- Nunca commite chaves de API ou credenciais
- Use GitHub Secrets para CI/CD
- Revise sempre código gerado antes de commitar
- Mantenha dependências atualizadas via Dependabot
