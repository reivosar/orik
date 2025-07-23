# Traceability Matrix

## 0. Meta
- **Project**: {{PROJECT_NAME}}
- **Version**: {{VERSION}} ({{DATE}})
- **Owner**: {{OWNER}}
- **Last Updated**: {{DATE}}
- **Status**: Active | Deprecated

---

## 1. Overview

This document maintains complete traceability from requirements through implementation to testing. Every functional requirement (FR) must trace through feature specifications (FS), design components (D), implementation tasks (T), and test cases (TC).

### 1.1 Document Relationships
```
FR (Requirements) → FS (Feature Specs) → D (Design) → T (Tasks) → TC (Test Cases)
     ↓                    ↓                 ↓           ↓          ↓
 User needs        Implementation    Component    Code      Verification
                     details         design     changes      
```

### 1.2 Coverage Requirements
- **100% FR → FS**: Every requirement must have at least one feature spec
- **100% FS → D**: Every feature spec must reference design components  
- **100% D → T**: Every design component must have implementation tasks
- **100% T → TC**: Every task must have test case verification
- **90%+ Code Coverage**: Tests must cover 90%+ of code with FR/AC tags

---

## 2. Traceability Matrix

### 2.1 Complete Traceability Chain

| FR | FR Title | FS | FS Title | D | D Title | T | T Title | TC | TC Title | Status |
|----|----------|----|---------|----|---------|----|---------|----|----------|--------|
| FR-001 | {{Requirement Title}} | FS-001 | {{Feature Spec Title}} | D-001 | {{Component Name}} | T-001 | {{Task Title}} | TC-001 | {{Test Title}} | ✅ Complete |
| FR-001 | {{Requirement Title}} | FS-001 | {{Feature Spec Title}} | D-002 | {{Component Name}} | T-002 | {{Task Title}} | TC-002 | {{Test Title}} | ✅ Complete |
| FR-002 | {{Requirement Title}} | FS-002 | {{Feature Spec Title}} | D-003 | {{Component Name}} | T-003 | {{Task Title}} | TC-003 | {{Test Title}} | 🔄 In Progress |
| FR-002 | {{Requirement Title}} | FS-003 | {{Feature Spec Title}} | D-003 | {{Component Name}} | T-004 | {{Task Title}} | TC-004 | {{Test Title}} | ❌ Missing TC |
| FR-003 | {{Requirement Title}} | FS-004 | {{Feature Spec Title}} | D-004 | {{Component Name}} | T-005 | {{Task Title}} | TC-005 | {{Test Title}} | ⚠️ Orphaned |

### 2.2 Status Legend
- ✅ **Complete**: Full traceability chain established and verified
- 🔄 **In Progress**: Implementation or testing in progress
- ❌ **Missing**: Required document/test case missing
- ⚠️ **Orphaned**: Referenced document doesn't exist
- 🚫 **Deprecated**: Document marked as deprecated

---

## 3. Requirements Coverage Analysis

### 3.1 FR → FS Coverage
| FR ID | FR Title | Linked FS | Coverage Status | Notes |
|-------|----------|-----------|-----------------|-------|
| FR-001 | {{Title}} | FS-001 | ✅ Covered | Complete spec |
| FR-002 | {{Title}} | FS-002, FS-003 | ✅ Covered | Multiple specs |
| FR-003 | {{Title}} | - | ❌ Missing FS | **ACTION REQUIRED** |
| FR-004 | {{Title}} | FS-004 | ⚠️ Draft | FS in review |

**Coverage Summary**: {{X}}/{{Y}} FRs have complete FS coverage ({{Z}}%)

### 3.2 FS → D Coverage
| FS ID | FS Title | Linked D | Coverage Status | Notes |
|-------|----------|----------|-----------------|-------|
| FS-001 | {{Title}} | D-001, D-002 | ✅ Covered | Multiple components |
| FS-002 | {{Title}} | D-003 | ✅ Covered | Single component |
| FS-003 | {{Title}} | - | ❌ Missing D | **ACTION REQUIRED** |
| FS-004 | {{Title}} | D-004 | ⚠️ Draft | D in review |

**Coverage Summary**: {{X}}/{{Y}} FSs have complete D coverage ({{Z}}%)

### 3.3 D → T Coverage
| D ID | D Title | Linked T | Coverage Status | Notes |
|------|---------|----------|-----------------|-------|
| D-001 | {{Title}} | T-001, T-002 | ✅ Covered | Multiple tasks |
| D-002 | {{Title}} | T-003 | ✅ Covered | Single task |
| D-003 | {{Title}} | - | ❌ Missing T | **ACTION REQUIRED** |
| D-004 | {{Title}} | T-004 | 🔄 In Progress | Implementation started |

**Coverage Summary**: {{X}}/{{Y}} Ds have complete T coverage ({{Z}}%)

### 3.4 T → TC Coverage
| T ID | T Title | Linked TC | Coverage Status | Notes |
|------|---------|-----------|-----------------|-------|
| T-001 | {{Title}} | TC-001, TC-002 | ✅ Covered | Unit + Integration tests |
| T-002 | {{Title}} | TC-003 | ✅ Covered | Unit test only |
| T-003 | {{Title}} | - | ❌ Missing TC | **ACTION REQUIRED** |
| T-004 | {{Title}} | TC-004 | 🔄 In Progress | Test implementation started |

**Coverage Summary**: {{X}}/{{Y}} Ts have complete TC coverage ({{Z}}%)

---

## 4. Acceptance Criteria Traceability

### 4.1 AC → Test Case Mapping
| FR ID | AC ID | AC Description | TC ID | Test Status | Coverage |
|-------|-------|----------------|-------|-------------|----------|
| FR-001 | AC-001 | {{AC Description}} | TC-001 | ✅ Pass | Covered |
| FR-001 | AC-002 | {{AC Description}} | TC-002 | ✅ Pass | Covered |
| FR-001 | AC-003 | {{AC Description}} | - | ❌ No Test | **MISSING** |
| FR-002 | AC-004 | {{AC Description}} | TC-003 | 🔄 Running | In Progress |

**AC Coverage Summary**: {{X}}/{{Y}} ACs have test coverage ({{Z}}%)

---

## 5. Implementation Status Dashboard

### 5.1 Overall Progress
```
Requirements    ████████████████████ 100% ({{X}}/{{Y}} FR)
Feature Specs   ███████████████████░  95% ({{X}}/{{Y}} FS)
Design          ████████████████░░░░  80% ({{X}}/{{Y}} D)
Implementation  ████████████░░░░░░░░  60% ({{X}}/{{Y}} T)
Testing         ████████░░░░░░░░░░░░  40% ({{X}}/{{Y}} TC)
```

### 5.2 Status by Document Type
| Document Type | Total | Complete | In Progress | Missing | Deprecated |
|---------------|-------|----------|-------------|---------|------------|
| FR | {{N}} | {{X}} | {{Y}} | {{Z}} | {{W}} |
| FS | {{N}} | {{X}} | {{Y}} | {{Z}} | {{W}} |
| D | {{N}} | {{X}} | {{Y}} | {{Z}} | {{W}} |
| T | {{N}} | {{X}} | {{Y}} | {{Z}} | {{W}} |
| TC | {{N}} | {{X}} | {{Y}} | {{Z}} | {{W}} |

---

## 6. Quality Metrics

### 6.1 Traceability Health Score
- **Complete Chains**: {{X}}/{{Y}} requirements have end-to-end traceability ({{Z}}%)
- **Orphaned Documents**: {{N}} documents without proper links
- **Missing Coverage**: {{N}} requirements without adequate testing
- **Deprecated Items**: {{N}} items marked as deprecated

### 6.2 Test Coverage Analysis
```typescript
// Code coverage with FR/AC tag analysis
interface CoverageReport {
  totalLines: number;
  coveredLines: number;
  coveragePercentage: number;
  frTaggedTests: number;
  acTaggedTests: number;
  untaggedTests: number;
}
```

| FR ID | Code Coverage | FR-Tagged Tests | AC-Tagged Tests | Coverage Quality |
|-------|---------------|-----------------|-----------------|------------------|
| FR-001 | 95% | 5 | 8 | ✅ Excellent |
| FR-002 | 87% | 3 | 6 | ✅ Good |
| FR-003 | 65% | 2 | 3 | ⚠️ Needs Improvement |
| FR-004 | 45% | 1 | 1 | ❌ Poor |

---

## 7. Action Items & Risks

### 7.1 Critical Issues (Blocking)
- [ ] **FR-003**: Missing feature specification (FS-005) - **Owner**: {{OWNER}} - **Due**: {{DATE}}
- [ ] **D-007**: No implementation tasks defined - **Owner**: {{OWNER}} - **Due**: {{DATE}}
- [ ] **T-015**: Missing test cases for critical path - **Owner**: {{OWNER}} - **Due**: {{DATE}}

### 7.2 High Priority Issues
- [ ] **FS-009**: Incomplete design mapping - **Owner**: {{OWNER}} - **Due**: {{DATE}}
- [ ] **TC-023**: Test case needs AC tagging - **Owner**: {{OWNER}} - **Due**: {{DATE}}
- [ ] **Coverage**: FR-004 below minimum coverage threshold - **Owner**: {{OWNER}} - **Due**: {{DATE}}

### 7.3 Technical Debt
- [ ] **ADR-001**: Architecture decision needs documentation - **Owner**: {{OWNER}} - **Due**: {{DATE}}
- [ ] **Refactor**: Legacy code lacks FR tags - **Owner**: {{OWNER}} - **Due**: {{DATE}}

---

## 8. Automation & CI Integration

### 8.1 Automated Checks
```bash
# Daily traceability validation
./scripts/validate-traceability.py docs/trace.md

# Coverage report generation  
./scripts/generate-coverage-report.py --with-fr-tags

# Orphan detection
./scripts/find-orphans.py docs/
```

### 8.2 CI Gate Requirements
- **Traceability Check**: All new FRs must have FS within 48 hours
- **Coverage Gate**: No PR merge if coverage drops below 90%
- **Orphan Detection**: Build fails on orphaned references
- **Tag Validation**: All tests must have proper FR/AC tags

### 8.3 Reporting Schedule
- **Daily**: Automated traceability validation
- **Weekly**: Coverage trend analysis
- **Monthly**: Complete trace matrix review
- **Release**: Full end-to-end verification

---

## 9. Change Management

### 9.1 Update Process
1. **New Requirement**: Add FR → Create FS → Update trace matrix
2. **Requirement Change**: Update all linked documents → Verify traceability
3. **Implementation Complete**: Update task status → Verify test coverage
4. **Deprecation**: Mark as deprecated → Update trace matrix → Notify stakeholders

### 9.2 Version Control
- **Matrix Version**: Increment on structural changes
- **Snapshot Tags**: Tag matrix at major releases
- **Change Log**: Track all modifications with reasons

### 9.3 Stakeholder Notifications
- **Missing Coverage**: Alert product owner daily
- **Orphaned Documents**: Alert tech leads immediately  
- **Coverage Drop**: Alert QA team on threshold breach
- **Complete Chains**: Celebrate milestone achievements

---

## 10. Appendix

### 10.1 Document Templates Used
- `requirements-template.md` for FR documents
- `feature-spec-template.md` for FS documents
- `design-template.md` for D documents
- `tasks-template.md` for T documents
- `adr-template.md` for ADR documents

### 10.2 Tools & Scripts
- `trace-validator.py`: Validates traceability relationships
- `coverage-analyzer.py`: Analyzes test coverage with FR/AC tags
- `orphan-detector.py`: Finds unreferenced documents
- `matrix-generator.py`: Auto-generates trace matrix from documents

### 10.3 Related Policies
- System Design Policy (SDP): Document standards and requirements
- Quality Gates: CI/CD integration requirements
- Change Management: Process for updating traceability

---

## 11. Emergency Procedures

### 11.1 Traceability Break
If traceability chain is broken:
1. **Immediate**: Mark affected items as ⚠️ Orphaned
2. **Within 4 hours**: Identify root cause
3. **Within 24 hours**: Restore traceability or create explicit exception
4. **Post-incident**: Update process to prevent recurrence

### 11.2 Coverage Drop
If coverage falls below threshold:
1. **Immediate**: Block new feature development
2. **Within 8 hours**: Identify missing test cases
3. **Within 48 hours**: Restore coverage above threshold
4. **Post-fix**: Review coverage strategy

---

**Last Updated**: {{DATE}} by {{UPDATER}}
**Next Review**: {{NEXT_REVIEW_DATE}}
**Auto-Generated**: This matrix is partially auto-generated from document analysis