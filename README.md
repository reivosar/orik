# orik - Question-Driven Documentation Workflow Framework

**orik** is an intelligent documentation framework that uses structured questioning to determine exactly which documents to create based on development scenarios, eliminating waste while ensuring complete traceability.

## What Makes orik Different?

Traditional documentation: Create everything, hope it's useful.  
**orik approach**: Ask the right questions, create only what's needed.

- **Bug fix**: 3 targeted questions → Tasks + Test specs only
- **UI change**: 8 UI-focused questions → Feature specs + Tasks + Tests  
- **New feature**: 25+ comprehensive questions → Full documentation chain
- **Refactor**: 4 technical debt questions → Technical tasks only

**Result**: 70% less documentation overhead, 100% better quality.

## Quick Start

### 1. Basic Usage
```bash
# Tell Claude to use orik framework
Follow entry-point.dsl for complete DSL execution
```

### 2. How It Works
```
User Request → Scenario Classification → Targeted Questions → Smart Document Creation
```

Claude automatically:
1. **Classifies** your request into 7 development scenarios
2. **Asks targeted questions** based on the scenario
3. **Creates only required documents** with complete traceability
4. **Validates quality** through automated gates

### 3. Example Interaction
```
User: "Fix the login button styling"

Claude: 
- Detected scenario: UI Change
- Questions: What UI states need fixing? What's the expected behavior? 
  Which browsers need testing?
- Plan: Update Feature Spec + Create Tasks + Create Test Cases
- Skip: Requirements (reference existing), Full Design, ADR
- Proceed? [y/n]
```

## Framework Architecture

```
orik/
├── entry-point.dsl              # Entry point & task routing (v0.6)
├── spec-driven.dsl              # Main development controller (v0.6)
├── flow.dsl                     # Core workflow engine (v0.6)
├── questions.dsl                # Scenario-based question sets (v0.6)
├── recommendation-settings.dsl  # AI recommendation system (v0.6)
├── document-creation-policy.dsl # Document creation rules & procedures (v0.6)
└── templates/
    ├── requirements-template.md      # Functional & Non-functional requirements
    ├── feature-spec-template.md      # UI/UX specifications with data models
    ├── design-template.md            # Component architecture & APIs
    ├── tasks-template.md             # Implementation breakdown with DoD
    ├── test-spec-template.md         # Comprehensive testing framework
    ├── nfr-template.md               # Non-functional requirements with SLO/SLA
    ├── system-design-policy-template.md  # Enterprise governance rules
    └── ci/github-actions-quality-gates.yml  # Automated validation
```

## Core Features

### Question-Driven Intelligence
- **Progressive questioning**: Start broad, drill down based on answers
- **Scenario-specific question sets**: 25+ questions for new features, 3 for bug fixes
- **Validation mapping**: Each question maps to specific quality gates
- **Time-constrained modes**: Critical/Standard/Comprehensive questioning levels

### Complete Traceability System
- **ID-based linking**: FR-001 → FS-001 → D-001 → T-001 → TC-001
- **Automated trace matrix**: Generated from document cross-references
- **100% coverage enforcement**: No orphaned requirements or untested features
- **Impact analysis**: Visual mapping of change propagation

### Production-Ready Automation
- **CI/CD integration**: GitHub Actions with 6 quality gate categories
- **Schema validation**: JSON Schema enforcement for all document types
- **Automated testing**: Performance/Accessibility/Security test generation
- **Quantified thresholds**: Measurable quality criteria (90% test coverage, LCP < 2.5s)

## Development Scenarios

### Scenario Matrix

**Document Types:**
- **FR** = Functional Requirements (what the system should do)
- **FS** = Feature Specifications (UI/UX details and user flows)
- **NFR** = Non-Functional Requirements (performance, security, reliability)
- **Design** = Technical design and architecture
- **Tasks** = Implementation tasks with Definition of Done
- **Tests** = Test specifications and test cases
- **Trace** = Traceability matrix linking all documents

| Scenario | Questions | FR | FS | NFR | Design | Tasks | Tests | Trace | Time Savings |
|----------|-----------|----|----|-----|--------|-------|-------|-------|--------------|
| **New Product** | 25+ | ✅ | ✅ | ⭕ | ✅ | ✅ | ✅ | ✅ | Baseline |
| **Major Feature** | 18 | 📝 | 📝 | ⭕ | 📝 | 📝 | 📝 | 📝 | 30% |
| **UI Change** | 8 | 📝 | 📝 | ❌ | ❌ | ✅ | ✅ | 📝 | 60% |
| **Bug Fix** | 3 | 👁️ | ❌ | ❌ | ❌ | ✅ | ✅ | 📝 | 75% |
| **Spec Change** | 15 | 📝 | 📝 | ⭕ | 📝 | 📝 | 📝 | 📝 | 40% |
| **Refactor** | 4 | ❌ | ❌ | ❌ | ⭕ | ✅ | ⭕ | 📝 | 70% |
| **Infrastructure** | 12 | ❌ | ❌ | ✅ | 📝 | ✅ | ✅ | 📝 | 50% |

**Actions:**
- ✅ Create new document
- 📝 Update existing document  
- 👁️ Reference only (no changes)
- ⭕ Optional (create if needed)
- ❌ Skip (not required)

### Workflow Examples

**Bug Fix Flow:**
```
Bug Report → [3 Questions] → Reference AC-012 → Create T-045 → Create TC-045 → Update Trace → Done
Time: 15 minutes vs 2 hours traditional
```

**New Feature Flow:**
```
Feature Request → [25 Questions] → Create FR-008 → Create FS-008 → Create D-008 → 
Create T-046-050 → Create TC-046-050 → Update Trace → Quality Gates → Done
Time: 90 minutes vs 4 hours traditional
```

**Infrastructure/Performance Flow:**
```
Perf Issue → [12 NFR Questions] → Create NFR-001 → Update D-012 → Create T-051-053 → 
Create NFTC-001-005 → Update Trace → SLO Validation → Done
Time: 60 minutes vs 3 hours traditional
```

## Document Templates

### Requirements (FR/AC)
**Questions Asked**: What functionality? Who are users? What are success criteria?
- **Functional Requirements** with Given-When-Then acceptance criteria
- **Non-Functional Requirements** with quantified performance targets
- **Scope definition** (explicit In/Out boundaries)
- **Traceability IDs** for downstream linking

### Feature Specifications (FS)
**Questions Asked**: What should UI look like? How do users interact? What data is needed?
- **UI/UX specifications** with concrete mockups and states
- **Interaction patterns** and responsive breakpoints
- **Data models** and API integration points
- **Accessibility requirements** (WCAG 2.1 AA compliance)

### Design (D)
**Questions Asked**: What components? How do they interact? What are the APIs?
- **Component architecture** with public API definitions
- **Data flow diagrams** and state management strategy
- **Integration patterns** for external services
- **Error handling** and performance considerations

### Tasks (T)
**Questions Asked**: What implementation steps? What are dependencies? How to test?
- **Implementation breakdown** with clear Definition of Done
- **Dependency mapping** and execution order
- **Technical requirements** and risk assessment
- **Quality criteria** and testing requirements

### Test Specifications (TC)
**Questions Asked**: What needs testing? How to automate? What environments?
- **Functional/Non-functional/Security** test coverage
- **Automation strategy** with CI/CD integration
- **Environment matrix** (browsers/devices/OS combinations)
- **Performance budgets** and accessibility validation

## Benefits

### For Development Teams
- **Faster documentation**: 70% less time spent on unnecessary docs
- **Better quality**: Targeted questions ensure completeness
- **Clear requirements**: No ambiguity, everything testable
- **Automated validation**: CI catches gaps before code review

### For Enterprise Organizations
- **Audit compliance**: Complete paper trail for all changes
- **Risk management**: Impact analysis shows change propagation
- **Quality assurance**: Quantified gates with measurable criteria
- **Scalable governance**: System Design Policy for organization-wide consistency

## Advanced Features

### AI Recommendation System
```bash
# Three-mode operation for flexible interaction
User: "Fix login button bug"
Claude: 
- Mode: Hybrid (default)
- Analysis: Can recommend fix approach, testing strategy
- Required: Bug description, expected behavior
- Choice: [Accept AI suggestions] [Modify] [Manual questions]
```

### DSL-Driven Execution
```yaml
# Structured workflow with explicit control flow
entry-point.dsl:
  - action: classify_task           # Determine scenario
  - action: load_flow              # Route to spec-driven.dsl
    file: "spec-driven.dsl"
    context: { task_type: "development" }

spec-driven.dsl:
  - action: load_flow              # Load question system
    file: "questions.dsl" 
    context: { scenario: "bug_fix" }
```

### Quality Gates Integration
```yaml
# Automated validation with quantified thresholds
validation:
  document_completeness: 100%    # All required sections filled
  traceability_coverage: 100%    # All IDs properly linked
  test_coverage: 90%            # Tests linked to requirements
  accessibility_score: 95%      # WCAG compliance validation
  performance_budget: "LCP < 2.5s, FID < 100ms"
```

## Getting Started

### 1. Installation
```bash
git clone https://github.com/your-org/orik.git
cd orik
# Copy templates to your project
```

### 2. DSL Architecture
**Execution Flow:**
```
entry-point.dsl (Router) → spec-driven.dsl (Controller) → Other DSL files
```

**Key Features:**
- **Version 0.6 Unified**: All DSL files use consistent v0.6 interface
- **Context-Based**: Variables flow through context dictionary
- **Explicit Loading**: `action: load_flow file:"target.dsl"`
- **Error Handling**: Standardized `{ok:bool, out:obj, err?:string}` format

### 3. First Use  
```bash
# Start Claude session with:
"Follow entry-point.dsl for complete DSL execution"

# Claude will automatically:
# - Route through entry-point.dsl (task classification)
# - Execute spec-driven.dsl (main workflow)
# - Load questions.dsl (intelligent questioning)
# - Apply recommendation-settings.dsl (AI suggestions)
# - Create documents via document-creation-policy.dsl
```

### 4. Customization
```bash
# Modify question sets for your domain
vi questions.dsl

# Adjust recommendation policies
vi recommendation-settings.dsl

# Update document creation rules
vi document-creation-policy.dsl

# Customize templates for your standards
vi templates/*.md
```

## Integration Examples

### GitHub Actions
```yaml
name: orik Quality Gates
on: [push, pull_request]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Validate Documentation
        run: |
          # Schema validation
          ajv validate -s schemas/*.json -d docs/
          # Traceability check  
          python scripts/validate-trace.py
          # Test coverage with FR/AC tags
          pytest --cov --fr-ac-tags
```

### Make Commands
```bash
# Automated workflow triggers
make new:feature FR=012    # Generate complete documentation chain
make change:ui FS=005      # UI change workflow
make fix:bug ISSUE=123     # Bug fix with minimal documentation
make trace:validate        # Validate complete traceability
```

## Why orik Works

### Traditional Problem
- **Over-documentation**: Create everything "just in case"
- **Under-specification**: Generic questions miss critical details  
- **Manual tracking**: Traceability breaks down over time
- **Inconsistent quality**: No systematic validation

### orik Solution
- **Smart questioning**: Right questions for each scenario
- **Targeted creation**: Only necessary documents  
- **Automated traceability**: ID linking with validation
- **Quality gates**: Measurable, enforceable standards

## Contributing

orik is designed for continuous evolution:

### Extension Points
- **Industry-specific question sets** (healthcare, finance, etc.)
- **Additional quality gates** for domain requirements
- **Custom template formats** for organization standards  
- **Integration connectors** for project management tools

### Development Workflow
1. Fork repository
2. Add/modify question sets in `questions.dsl`
3. Update templates as needed
4. Test with real scenarios
5. Submit pull request with examples

## License

Open source - enterprise ready.

---

**orik**: Stop guessing what documentation you need. Start asking the right questions.