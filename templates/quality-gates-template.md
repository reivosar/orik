# Quality Gates & CI Rules

## 0. Meta
- **Document**: Quality Gates & CI Rules
- **Version**: 0.1 ({{DATE}})
- **Owner**: {{CI/CD_TEAM}}
- **Applies to**: All repositories in {{PROJECT/ORGANIZATION}}
- **Status**: Active | Draft | Deprecated

---

## 1. Overview

This document defines the mandatory quality gates and CI/CD rules that every pull request and deployment must pass. These gates ensure code quality, security, performance, and compliance with organizational standards.

### 1.1 Purpose
- **Prevent defects** from reaching production
- **Maintain consistency** across all codebases
- **Ensure compliance** with security and accessibility standards
- **Automate quality assurance** processes
- **Enable fast, safe deployments**

### 1.2 Gate Categories
- **🔒 Blocking Gates**: Must pass for PR merge/deployment
- **⚠️ Warning Gates**: Generate warnings but don't block
- **📊 Reporting Gates**: Collect metrics and generate reports

---

## 2. Document Quality Gates

### 2.1 Documentation Schema Validation 🔒
**Purpose**: Ensure all documents follow required templates and contain mandatory fields

**Implementation**:
```bash
# JSON Schema validation for all document types
ajv validate -s schemas/requirements.schema.json -d docs/requirements/*.md
ajv validate -s schemas/feature-specs.schema.json -d docs/specs/*.md
ajv validate -s schemas/design.schema.json -d docs/design/*.md
ajv validate -s schemas/adr.schema.json -d docs/decisions/*.md
```

**Pass Criteria**:
- All documents pass schema validation
- Required fields are present and properly formatted
- ID format follows convention (FR-XXX, FS-XXX, etc.)

**Failure Action**: Block PR merge until validation passes

### 2.2 Traceability Validation 🔒
**Purpose**: Ensure complete traceability from requirements to test cases

**Implementation**:
```bash
# Traceability chain validation
python scripts/validate-traceability.py docs/trace.md
```

**Pass Criteria**:
- No orphaned document references
- Complete FR → FS → D → T → TC chains
- All new FRs have corresponding FS within 48 hours
- Trace matrix is updated and consistent

**Failure Action**: Block PR merge until traceability is restored

### 2.3 Document Content Quality ⚠️
**Purpose**: Maintain high quality documentation standards

**Implementation**:
```bash
# Spelling and grammar check
cspell "docs/**/*.md"

# Link validation
markdown-link-check docs/**/*.md

# Readability analysis
textstat docs/**/*.md
```

**Pass Criteria**:
- No spelling errors in technical documentation
- All internal and external links are valid
- Readability score meets minimum threshold

**Failure Action**: Generate warnings, require manual review

---

## 3. Code Quality Gates

### 3.1 Linting & Formatting 🔒
**Purpose**: Ensure consistent code style and catch common errors

**Implementation**:
```bash
# TypeScript/JavaScript
eslint src/ --ext .ts,.tsx,.js,.jsx
prettier --check src/

# Python
flake8 src/
black --check src/

# CSS/SCSS
stylelint src/**/*.{css,scss}
```

**Pass Criteria**:
- Zero linting errors (warnings allowed)
- Code follows formatting standards
- No unused imports or variables
- Consistent naming conventions

**Failure Action**: Block PR merge until all errors are fixed

### 3.2 Type Safety 🔒
**Purpose**: Catch type-related errors before runtime

**Implementation**:
```bash
# TypeScript type checking
tsc --noEmit --strict

# Python type checking
mypy src/
```

**Pass Criteria**:
- No TypeScript compilation errors
- All functions have proper type annotations
- Strict type checking passes

**Failure Action**: Block PR merge until type errors are resolved

### 3.3 Code Complexity Analysis ⚠️
**Purpose**: Identify overly complex code that may be hard to maintain

**Implementation**:
```bash
# Cyclomatic complexity analysis
complexity-report src/ --threshold 10

# Code duplication detection
jscpd src/ --threshold 3
```

**Pass Criteria**:
- Cyclomatic complexity ≤ 10 per function
- Code duplication ≤ 3%
- No functions exceed 50 lines (configurable)

**Failure Action**: Generate warnings, require architectural review for high complexity

---

## 4. Testing Quality Gates

### 4.1 Unit Test Coverage 🔒
**Purpose**: Ensure adequate test coverage for all code changes

**Implementation**:
```bash
# Jest coverage for JavaScript/TypeScript
jest --coverage --collectCoverageFrom="src/**/*.{ts,tsx}"

# pytest coverage for Python  
pytest --cov=src --cov-report=xml --cov-fail-under=90
```

**Pass Criteria**:
- Overall coverage ≥ 90%
- New code coverage ≥ 95%
- No untested critical paths
- Coverage delta doesn't decrease

**Failure Action**: Block PR merge until coverage threshold is met

### 4.2 Test Execution 🔒
**Purpose**: Ensure all tests pass consistently

**Implementation**:
```bash
# Run all test suites
npm run test:unit
npm run test:integration
npm run test:e2e
```

**Pass Criteria**:
- All unit tests pass
- All integration tests pass
- E2E tests pass (with retry for flaky tests)
- No test timeouts or memory leaks

**Failure Action**: Block PR merge until all tests pass

### 4.3 FR/AC Tag Coverage 🔒
**Purpose**: Ensure tests are properly linked to requirements

**Implementation**:
```bash
# Validate FR/AC tags in test files
python scripts/validate-test-tags.py src/
```

**Pass Criteria**:
- All tests have proper FR-XXX or AC-XXX tags
- New features have corresponding test tags
- Tag references exist in trace matrix

**Failure Action**: Block PR merge until proper tags are added

---

## 5. Security Quality Gates

### 5.1 Static Security Analysis 🔒
**Purpose**: Identify security vulnerabilities in code

**Implementation**:
```bash
# SAST scanning
semgrep --config=auto src/
bandit -r src/ # Python
eslint-plugin-security # JavaScript

# Secrets detection
gitleaks detect
```

**Pass Criteria**:
- No high or critical severity vulnerabilities
- No hardcoded secrets or credentials
- No known insecure patterns

**Failure Action**: Block PR merge until security issues are resolved

### 5.2 Dependency Vulnerability Scan 🔒
**Purpose**: Ensure no vulnerable dependencies are introduced

**Implementation**:
```bash
# NPM audit
npm audit --audit-level=moderate

# Python safety check
safety check

# Container scanning (if applicable)
trivy image {{image_name}}
```

**Pass Criteria**:
- No high or critical vulnerabilities in dependencies
- All dependencies are up-to-date within acceptable range
- No dependencies with known malware

**Failure Action**: Block PR merge until vulnerabilities are patched or mitigated

### 5.3 License Compliance 📊
**Purpose**: Ensure all dependencies have acceptable licenses

**Implementation**:
```bash
# License checking
license-checker --onlyAllow "MIT;Apache-2.0;BSD-3-Clause;ISC"
```

**Pass Criteria**:
- All dependencies use approved licenses
- No GPL or copyleft licenses (unless approved)
- License compatibility verified

**Failure Action**: Generate report, require legal review for new licenses

---

## 6. Performance Quality Gates

### 6.1 Build Performance ⚠️
**Purpose**: Ensure builds complete within reasonable time

**Implementation**:
```bash
# Build time monitoring
time npm run build
```

**Pass Criteria**:
- Build completes within {{X}} minutes
- Bundle size doesn't exceed {{Y}} MB
- No significant performance regression (>20% slower)

**Failure Action**: Generate warnings, require optimization for significant regressions

### 6.2 Runtime Performance 🔒
**Purpose**: Ensure application meets performance requirements

**Implementation**:
```bash
# Lighthouse CI for web applications
lhci autorun

# Load testing for APIs
k6 run performance-tests/
```

**Pass Criteria**:
- Lighthouse performance score ≥ 90
- Page load time ≤ 2 seconds
- API response time ≤ 200ms (95th percentile)
- Memory usage within acceptable limits

**Failure Action**: Block deployment until performance requirements are met

### 6.3 Bundle Analysis 📊
**Purpose**: Monitor and control application bundle size

**Implementation**:
```bash
# Bundle analysis
webpack-bundle-analyzer dist/
```

**Pass Criteria**:
- Total bundle size ≤ {{X}}MB
- No duplicate dependencies
- Tree shaking effectively removes unused code

**Failure Action**: Generate report, require review for significant size increases

---

## 7. Accessibility Quality Gates

### 7.1 Automated Accessibility Testing 🔒
**Purpose**: Ensure basic accessibility compliance

**Implementation**:
```bash
# axe-core automated testing
jest-axe src/
cypress-axe # E2E accessibility testing

# Pa11y CLI testing
pa11y http://localhost:3000
```

**Pass Criteria**:
- No WCAG 2.1 AA violations
- Color contrast ratio ≥ 4.5:1
- All interactive elements are keyboard accessible
- Screen reader compatibility verified

**Failure Action**: Block PR merge until accessibility issues are resolved

### 7.2 Keyboard Navigation Testing ⚠️
**Purpose**: Ensure full keyboard accessibility

**Implementation**:
```bash
# Automated keyboard navigation testing
cypress run --spec "cypress/accessibility/keyboard.spec.js"
```

**Pass Criteria**:
- All interactive elements reachable via keyboard
- Focus order is logical and consistent
- No keyboard traps
- Skip links function properly

**Failure Action**: Generate warnings, require manual accessibility review

---

## 8. Deployment Quality Gates

### 8.1 Environment Validation 🔒
**Purpose**: Ensure proper environment configuration

**Implementation**:
```bash
# Environment variable validation
python scripts/validate-env.py

# Health check endpoints
curl -f http://localhost:8080/health
```

**Pass Criteria**:
- All required environment variables are set
- Health checks pass
- Database connections successful
- External service dependencies available

**Failure Action**: Block deployment until environment issues are resolved

### 8.2 Smoke Testing 🔒
**Purpose**: Verify basic functionality after deployment

**Implementation**:
```bash
# Smoke tests
npm run test:smoke

# API health checks
newman run postman/smoke-tests.json
```

**Pass Criteria**:
- All critical user journeys work
- Core APIs respond correctly
- Authentication/authorization functional
- No 5xx errors in logs

**Failure Action**: Trigger automatic rollback if smoke tests fail

---

## 9. CI/CD Pipeline Configuration

### 9.1 Pipeline Stages
```yaml
stages:
  - validate-docs
  - code-quality
  - test
  - security-scan
  - build
  - performance-test
  - accessibility-test
  - deploy-staging
  - smoke-test
  - deploy-production
```

### 9.2 Parallel vs Sequential Gates
**Parallel Execution** (for speed):
- Linting and formatting
- Unit tests
- Security scanning
- Documentation validation

**Sequential Execution** (dependencies):
- Build → Performance testing
- Deploy staging → Smoke tests → Deploy production

### 9.3 Gate Failure Handling
```yaml
on_failure:
  blocking_gates:
    action: fail_pipeline
    notification: immediate
  warning_gates:
    action: continue_with_warning
    notification: summary_report
  reporting_gates:
    action: continue
    notification: dashboard_update
```

---

## 10. Quality Metrics & Reporting

### 10.1 Key Quality Indicators (KQIs)
- **Gate Pass Rate**: Percentage of PRs passing all gates on first attempt
- **Time to Green**: Average time from PR creation to all gates passing
- **Defect Escape Rate**: Percentage of bugs found in production vs caught by gates
- **Coverage Trend**: Code coverage percentage over time
- **Security Score**: Number of vulnerabilities detected and resolved

### 10.2 Dashboard & Reporting
```bash
# Quality dashboard generation
python scripts/generate-quality-dashboard.py

# Weekly quality report
python scripts/weekly-quality-report.py
```

**Reports Include**:
- Gate success/failure trends
- Code quality metrics over time
- Security vulnerability trends
- Performance regression analysis
- Accessibility compliance status

### 10.3 Alert Thresholds
- **Critical**: Security vulnerabilities, accessibility failures
- **Warning**: Coverage drops, performance regressions
- **Info**: Code complexity increases, documentation gaps

---

## 11. Exemption & Override Process

### 11.1 Emergency Override
For production incidents only:
1. **Incident Commander** can override blocking gates
2. **Two-person approval** required (Incident Commander + Tech Lead)
3. **Post-incident review** mandatory within 24 hours
4. **Technical debt ticket** created automatically

### 11.2 Planned Exemptions
For known limitations or special cases:
1. **Architecture Review Board** approval required
2. **Exemption ticket** with justification and timeline
3. **Compensation controls** must be implemented
4. **Regular review** of active exemptions

### 11.3 Exemption Documentation
```yaml
exemption:
  id: EXP-001
  gate: security-scan
  justification: "Third-party library with false positive"
  approved_by: "security-team@company.com"
  expires: "2024-12-31"
  compensation: "Manual security review completed"
```

---

## 12. Tool Configuration

### 12.1 Required Tools
- **CI/CD Platform**: GitHub Actions | GitLab CI | Jenkins
- **Code Quality**: ESLint, Prettier, SonarQube
- **Testing**: Jest, Cypress, k6
- **Security**: Semgrep, npm audit, OWASP ZAP
- **Documentation**: JSON Schema, markdownlint
- **Performance**: Lighthouse CI, webpack-bundle-analyzer

### 12.2 Tool Versions
```yaml
tools:
  node: ">=18.0.0"
  eslint: "^8.0.0"
  jest: "^29.0.0"
  cypress: "^12.0.0"
  lighthouse: "^10.0.0"
  semgrep: "^1.0.0"
```

### 12.3 Configuration Files
- `.eslintrc.js` - Linting rules
- `jest.config.js` - Test configuration
- `lighthouse.config.js` - Performance budgets
- `.semgrepignore` - Security scan exclusions

---

## 13. Training & Onboarding

### 13.1 Developer Onboarding
New team members must complete:
- [ ] Quality gates overview training
- [ ] Tool setup and configuration
- [ ] Practice PR with all gates enabled
- [ ] Security awareness training
- [ ] Accessibility training

### 13.2 Continuous Learning
- **Monthly**: Tool updates and new features
- **Quarterly**: Quality metrics review and process improvements
- **Annually**: Complete quality strategy review

### 13.3 Resources
- [Internal Wiki: Quality Gates Guide]
- [Video Training: CI/CD Best Practices]
- [Slack Channel: #quality-gates-help]
- [Office Hours: Fridays 2-3 PM]

---

## 14. Maintenance & Updates

### 14.1 Regular Reviews
- **Weekly**: Gate performance and failure analysis
- **Monthly**: Tool updates and threshold adjustments
- **Quarterly**: Process improvements and new gate evaluation
- **Annually**: Complete strategy and tool stack review

### 14.2 Continuous Improvement
- **Feedback Collection**: Developer surveys and pain point analysis
- **A/B Testing**: New gates tested on subset of repositories
- **Industry Benchmarking**: Compare against industry standards
- **Tool Evaluation**: Regular assessment of new quality tools

### 14.3 Change Management
All changes to quality gates must:
- [ ] Have business justification
- [ ] Be tested in non-production environment
- [ ] Have rollback plan
- [ ] Be communicated to all stakeholders
- [ ] Be documented in this guide

---

## 15. Troubleshooting

### 15.1 Common Issues
**Gate fails inconsistently**:
- Check for flaky tests
- Verify environment consistency
- Review resource constraints

**Performance degradation**:
- Analyze pipeline execution times
- Optimize parallel execution
- Consider gate caching strategies

**False positives in security scanning**:
- Update tool configurations
- Add appropriate exclusions
- Consider alternative tools

### 15.2 Support Channels
- **Immediate Help**: #quality-gates-help Slack channel
- **Bug Reports**: quality-gates@company.com
- **Feature Requests**: Internal feature request portal
- **Emergency Override**: On-call incident commander

### 15.3 Escalation Path
1. **Level 1**: Team Lead or Senior Developer
2. **Level 2**: Platform/DevOps Team
3. **Level 3**: Architecture Review Board
4. **Level 4**: Engineering Leadership

---

## 16. Compliance & Audit

### 16.1 Regulatory Compliance
For regulated industries:
- **SOX Compliance**: All changes tracked and approved
- **HIPAA**: PHI data handling validation
- **PCI DSS**: Payment data security validation
- **GDPR**: Data privacy impact assessment

### 16.2 Audit Trail
All quality gate activities are logged:
- Gate execution results
- Override usage and justification
- Exemption approvals and reviews
- Quality metric trends

### 16.3 External Audит Support
- Automated compliance report generation
- Quality metrics dashboard for auditors
- Historical data retention for 7 years
- Evidence collection for security assessments

---

## Appendix A: Gate Configuration Examples

### A.1 GitHub Actions Configuration
```yaml
name: Quality Gates
on: [push, pull_request]
jobs:
  quality-gates:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Document Validation
        run: |
          npm run validate:docs
      - name: Code Quality
        run: |
          npm run lint
          npm run typecheck
      - name: Security Scan
        run: |
          npm audit
          npm run security:scan
      - name: Tests
        run: |
          npm run test:coverage
      - name: Accessibility Test
        run: |
          npm run test:a11y
```

### A.2 Quality Thresholds
```json
{
  "coverage": {
    "statements": 90,
    "branches": 85,
    "functions": 90,
    "lines": 90
  },
  "performance": {
    "lighthouse": 90,
    "bundleSize": "2MB",
    "loadTime": "2s"
  },
  "security": {
    "maxVulnerabilities": 0,
    "allowedLicenses": ["MIT", "Apache-2.0", "BSD-3-Clause"]
  }
}
```

---

**Document Status**: Active  
**Last Updated**: {{DATE}} by {{AUTHOR}}  
**Next Review**: {{NEXT_REVIEW_DATE}}  
**Related**: system-design-policy-template.md, traceability-template.md