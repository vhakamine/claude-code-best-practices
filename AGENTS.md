# Claude Code Agent Roster

This file explains which specialized agent should handle which type of task.

## security-reviewer

Use for security-sensitive code, authentication, authorization, data handling, input validation, dependency risk, infrastructure exposure, and compliance-impacting changes.

Primary output:
- Findings by severity
- Affected asset
- Attack path
- Recommended control
- Logging or detection requirement
- Residual risk

## test-writer

Use for unit tests, integration tests, regression coverage, test data design, mocking strategy, CI failures, and flaky test analysis.

Primary output:
- Test plan
- Coverage gaps
- Proposed test cases
- Failure-mode coverage
- Commands to run

## research

Use for documentation research, design comparison, standards lookup, dependency behavior, and summarizing technical background.

Primary output:
- Key findings
- Source notes
- Uncertainties
- Recommended implementation direction

## Delegation rule

Use one specialized agent for focused analysis. Do not ask multiple agents to perform the same work unless the task requires separate security, testing, and architecture viewpoints.
