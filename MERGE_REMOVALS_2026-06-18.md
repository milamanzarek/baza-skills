# Duplicate merges - host-side removal (2026-06-18)

The 9 approved duplicates were verified and the non-canonical copy archived to
`_archive\superseded-skills-2026-06-18\`. The assistant environment cannot delete files
(the mount blocks deletion), so removing the loser folders from `skills\` is a host step.

## Run on your machine (PowerShell or cmd), from baza-skills:
```
rmdir /s /q skills\internal-comms-community
rmdir /s /q skills\brand-guidelines-community
rmdir /s /q skills\error-diagnostics-error-analysis
rmdir /s /q skills\error-diagnostics-error-trace
rmdir /s /q skills\codebase-cleanup-refactor-clean
rmdir /s /q skills\codebase-cleanup-tech-debt
rmdir /s /q skills\dependency-management-deps-audit
rmdir /s /q skills\documentation-generation-doc-generate
rmdir /s /q skills\performance-testing-review-ai-review
```
Each is already copied under `_archive\superseded-skills-2026-06-18\`, so this loses nothing.

## Merge map (keep <- archived loser)
- internal-comms-anthropic            <- internal-comms-community            (keeper richer: has examples/)
- brand-guidelines-anthropic          <- brand-guidelines-community          (identical body)
- error-debugging-error-analysis      <- error-diagnostics-error-analysis    (identical body)
- code-refactoring-tech-debt          <- codebase-cleanup-tech-debt          (identical body)
- codebase-cleanup-deps-audit         <- dependency-management-deps-audit    (keeper richer: Output Format section)
- code-documentation-doc-generate     <- documentation-generation-doc-generate (identical body)
- code-review-ai-ai-review            <- performance-testing-review-ai-review (trivial: GPT-5 vs GPT-4.5)

## REVIEW THESE 2 before removing (real content drift, archived copy has unique lines):
- error-debugging-error-trace         <- error-diagnostics-error-trace       (~39 differing lines + different resources/implementation-playbook.md)
- code-refactoring-refactor-clean     <- codebase-cleanup-refactor-clean     (~36 differing lines)
If you want to combine their content, do that before deleting the archived copy.
