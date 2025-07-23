# System Design Policy (SDP)

## 0. Meta
- Version: 0.1 ({{DATE}})
- Owner: {{TEAM/ROLE}}
- Applies to: {{target project or all repositories}}
- Change Process: PR + architecture review required

---

## 1. Principles
- **MUST**: Readability > line reduction, testability > implementation shortcuts
- **MUST**: Maintain ID traceability from requirements→design→implementation→testing (FR/FS/D/T/TC)
- **SHOULD**: Design should be minimal, reusable, and loosely coupled
- **MAY**: Temporary hacks allowed with `TODO(@name, deadline)` annotation

---

## 2. Document Types & ID Conventions

### 2.1 Document Hierarchy
```
Requirements (FR-xxx) → Feature Specs (FS-xxx) → Design (D-xxx) → Tasks (T-xxx) → Test Cases (TC-xxx)
```

### 2.2 ID Rules
- **FR-xxx**: Functional Requirements (FR-001, FR-002, ...)
- **AC-xxx**: Acceptance Criteria (AC-001, AC-002, ...)
- **FS-xxx**: Feature Specifications (FS-001, FS-002, ...)
- **D-xxx**: Design Components (D-001, D-002, ...)
- **T-xxx**: Implementation Tasks (T-001, T-002, ...)
- **TC-xxx**: Test Cases (TC-001, TC-002, ...)
- **ADR-xxx**: Architecture Decision Records (ADR-001, ADR-002, ...)

**ID Management Rules:**
- **MUST**: Use sequential numbering only (FR-001, FR-002, FR-003...)
- **MUST**: Never reuse deleted IDs
- **MUST**: Mark unused IDs as `[DEPRECATED]` instead of deletion
- **MUST**: Maintain ID registry in trace.md

### 2.3 File Naming Conventions
- **Files**: `kebab-case.tsx`, `kebab-case.md`
- **Directories**: `lowercase-with-dash`
- **Types/Interfaces**: PascalCase
- **Constants**: UPPER_SNAKE_CASE

### 2.4 Directory Structure
```
src/
├── components/    # UI Presentational components
├── features/      # Domain-based features (state+logic+ui)
├── lib/           # General utilities
├── types/         # Type definitions and schemas
└── tests/         # Tests (same structure as src)
docs/
├── requirements/  # FR documents
├── specs/         # FS documents  
├── design/        # D documents
├── decisions/     # ADR documents
├── policies/      # This SDP and related policies
└── trace.md       # Traceability matrix
```

---

## 3. Document Templates & Requirements

### 3.1 Required Documents
- **MUST**: Every FR requires at least one FS
- **MUST**: Every FS requires corresponding D entries  
- **MUST**: Every D requires implementation T entries
- **MUST**: Every T requires TC verification
- **MUST**: Architectural changes require ADR

### 3.2 Document Relationships
- **1:N**: FR → FS (One requirement can have multiple specs)
- **N:N**: FS → D (Specs can reference multiple design components)
- **1:N**: D → T (One design component can have multiple tasks)
- **1:N**: T → TC (One task can have multiple test cases)

### 3.3 Mandatory Fields
Each document type must include:
- **All**: ID, version, owner, linked IDs
- **FR/FS**: acceptance criteria with Given-When-Then format
- **D**: public API specification
- **T**: DoD (Definition of Done), estimates, dependencies
- **TC**: verification steps with expected results

---

## 4. Change Management Process

### 4.1 Change Workflow
1. **Proposal**: Create issue with change proposal
2. **Impact Analysis**: Update trace.md to show affected documents
3. **Review**: Architecture review for D/ADR changes
4. **Implementation**: Update all linked documents
5. **Verification**: CI checks pass, traceability maintained
6. **Approval**: Merge after all gates pass

### 4.2 Version Management
- **Document Version**: MAJOR.MINOR format
- **MAJOR**: Breaking changes, ID structure changes
- **MINOR**: Non-breaking additions, clarifications
- **Change Log**: Required for all MAJOR versions

### 4.3 Deprecation Policy
- **MUST**: Mark as `[DEPRECATED - {{REASON}} - {{DATE}}]`
- **MUST**: Keep deprecated items for 2 major versions
- **SHOULD**: Provide migration path in deprecation notice

---

## 5. Traceability & Coverage Requirements

### 5.1 Traceability Matrix (trace.md)
- **MUST**: Maintain complete FR→FS→D→T→TC mapping
- **MUST**: Update trace.md with every ID change
- **MUST**: Validate traceability in CI

### 5.2 Coverage Requirements
- **MUST**: 100% FR coverage by FS
- **MUST**: 100% FS coverage by D  
- **MUST**: 100% T coverage by TC
- **SHOULD**: 90%+ code coverage with FR/AC tags

### 5.3 Orphan Detection
- **MUST**: CI fails on orphaned IDs (referenced but not defined)
- **MUST**: CI fails on unused IDs (defined but not referenced)
- **MAY**: Allow explicitly marked standalone documents

---

## 6. Quality Gates & CI Requirements

### 6.1 Document Quality Gates
- **MUST**: Schema validation (JSON Schema for structured data)
- **MUST**: Lint checks (spelling, format, required fields)
- **MUST**: Link validation (all ID references exist)
- **MUST**: Traceability check (no orphans, complete chains)

### 6.2 Implementation Quality Gates
- **MUST**: All tests pass with FR/AC tags
- **MUST**: Lint/format/typecheck pass
- **MUST**: Security checks pass
- **MUST**: Accessibility tests pass
- **MUST**: Performance budgets met

### 6.3 PR Requirements
Every PR must pass:
- [ ] Document schema validation
- [ ] Traceability matrix updated
- [ ] All linked documents updated
- [ ] Tests added/updated with proper tags
- [ ] Quality gates passed
- [ ] Architecture review (for D/ADR changes)

---

## 7. Architecture Rules
- **MUST**: Separate UI(Presentation) from Domain/Logic layers
- **MUST**: Abstract external IO layers (API/Storage) with interfaces
- **SHOULD**: Complete input→validation→processing→output flow in single location
- **MAY**: Choose microservices/monolith based on project scale

---

## 8. UI/UX Policy
- **MUST**: Components have single responsibility with explicit props
- **MUST**: Record text/colors/animation values in Spec(FS), avoid hardcoding
- **MUST**: All UI specifications must be in FS documents
- **SHOULD**: Quantify responsive/accessibility requirements in NFR
- **MAY**: Prioritize shadcn/ui, add custom UI only with reusability guarantee

---

## 9. Error & Logging
- **MUST**: Handle all failure cases and notify users/logs
- **MUST**: Use appropriate log levels: error/warn/info/debug
- **SHOULD**: Dictionary-based error messages for UI (i18n support)
- **MAY**: Wrap exceptions with domain-specific Error types

---

## 10. Data & Schema
- **MUST**: Define types and schemas (JSON Schema etc.) for all persistent/communication data
- **MUST**: Always validate received data
- **MUST**: Document data specifications in FS
- **SHOULD**: Explicit versioning (`version` field or API path)
- **MAY**: Use virtualization/pagination for large datasets

---

## 11. Performance Budgets
- **MUST**: Initial load < {{X}}s / LCP < {{Y}}s
- **MUST**: User action→UI response < 100ms
- **MUST**: Define performance requirements in FS
- **SHOULD**: Prevent unnecessary re-renders (memo/useCallback/useMemo)
- **MAY**: Consider WebWorker/wasm for heavy processing

---

## 12. Security & Privacy
- **MUST**: XSS/CSRF protection, input escaping, CSP configuration
- **MUST**: Encrypt/mask PII when handling sensitive data
- **SHOULD**: Don't rely solely on frontend for permission checks
- **MAY**: Include security lint/dependency vulnerability checks in CI

---

## 13. Accessibility
- **MUST**: WCAG 2.1 AA compliance (keyboard navigation, ARIA, contrast)
- **MUST**: Document accessibility requirements in FS
- **SHOULD**: Implement automated/manual accessibility testing in CI
- **MAY**: Provide keyboard shortcuts

---

## 14. Internationalization (i18n)
- **MUST**: Dictionary-based strings with `feature.scope.key` format keys
- **MUST**: Document all copy/messages in FS
- **SHOULD**: Locale support for dates/numbers/currency
- **MAY**: Automated testing for translation files

---

## 15. Testing & CI/CD
- **MUST**: Define 4 test layers: unit/integration/E2E/accessibility
- **MUST**: Auto-run lint/test/format/coverage on all PRs
- **MUST**: Tag tests with corresponding FR/AC IDs
- **SHOULD**: Measure coverage with FR/AC linked tags
- **MAY**: Introduce Visual Regression Testing

---

## 16. Documentation Standards
- **MUST**: Use provided templates for all document types
- **MUST**: Maintain complete traceability chains
- **SHOULD**: Add diffs and reasons to Change Log when making changes
- **MUST**: Maintain list of deprecated items, deletion only in major updates

---

## 17. Automation Requirements

### 17.1 Required CI Jobs
- **lint-docs**: Schema validation, format checking, spell check
- **trace-check**: Traceability validation, orphan detection
- **test-coverage**: FR/AC tag coverage measurement

### 17.2 CI Configuration
- **MUST**: Fail build on quality gate violations
- **MUST**: Generate traceability reports
- **SHOULD**: Auto-update trace.md when possible
- **MAY**: Generate documentation websites

---

## 18. Pull Request Checklist
- [ ] Are FR/AC/FS/D/T ID references consistent and complete?
- [ ] Did breaking changes to Public APIs follow policy procedures?
- [ ] Is error handling and logging sufficient?
- [ ] Does implementation meet NFR (performance/accessibility/security)?
- [ ] Are tests added/updated with proper FR/AC tags and coverage achieved?
- [ ] Are all linked documents updated (requirements/specs/design)?
- [ ] Is traceability matrix updated and validated?
- [ ] Are UI specifications complete in FS documents?
- [ ] Is ADR created for architectural decisions?

---

## 19. Tool Integration

### 19.1 Schema Validation
```bash
# Document validation
ajv validate -s docs/schemas/requirements.schema.json -d docs/requirements/
ajv validate -s docs/schemas/specs.schema.json -d docs/specs/
```

### 19.2 Traceability Check
```bash
# Python script for traceability validation
python scripts/trace-check.py docs/trace.md
```

### 19.3 Coverage Measurement
```bash
# Test coverage with FR/AC tags
pytest --cov --cov-report=html --fr-ac-tags
```

---

## 20. Operations Pattern
- Use this SDP as **top-level policy**, detailed policies for UI/data/security can be separated
- CI should validate minimum required fields, ID format compliance, and traceability
- Each section can be separated into individual files (`ui_policy.md`, `error_policy.md`) if needed
- Generate enforcement tools (linters, schemas, CI configs) from this policy

---

## Appendix: Regex Patterns for CI
```bash
# ID format validation
FR_PATTERN="^FR-[0-9]{3}$"
FS_PATTERN="^FS-[0-9]{3}$"  
D_PATTERN="^D-[0-9]{3}$"
T_PATTERN="^T-[0-9]{3}(\.[0-9]+)?$"
TC_PATTERN="^TC-[0-9]{3}$"
ADR_PATTERN="^ADR-[0-9]{3}$"

# Document structure validation
D_ID_HEADING="^### D-[0-9]{3}:"
API_LINE="^\s+- \`\w+\(.*\): .+\`"
AC_GWT="^Given .+\nWhen  .+\nThen  .+ SHALL$"
```