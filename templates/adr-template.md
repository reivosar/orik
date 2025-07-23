# ADR-{{XXX}}: {{Decision Title}}

## 0. Meta
- **ADR-ID**: ADR-{{XXX}}
- **Title**: {{Descriptive title of the architectural decision}}
- **Status**: Proposed | Accepted | Deprecated | Superseded by ADR-{{YYY}}
- **Date**: {{YYYY-MM-DD}}
- **Authors**: {{Author1}}, {{Author2}}
- **Reviewers**: {{Reviewer1}}, {{Reviewer2}}
- **Decision Makers**: {{DecisionMaker1}}, {{DecisionMaker2}}

---

## 1. Status
**{{Status}}** - {{YYYY-MM-DD}}

### Status History
- **{{YYYY-MM-DD}}**: Proposed by {{Author}}
- **{{YYYY-MM-DD}}**: Under Review
- **{{YYYY-MM-DD}}**: Accepted by {{DecisionMaker}}
- **{{YYYY-MM-DD}}**: [Additional status changes]

---

## 2. Context

### 2.1 Problem Statement
[Describe the architectural problem, challenge, or decision that needs to be made. What forces are at play? What are the constraints?]

### 2.2 Current Situation
[Describe the current architecture, technology stack, or approach that this decision will impact or replace]

### 2.3 Requirements & Constraints
- **Functional Requirements**: [What functionality must be supported?]
- **Non-Functional Requirements**: [Performance, scalability, security, etc.]
- **Business Constraints**: [Budget, timeline, compliance requirements]
- **Technical Constraints**: [Existing systems, team skills, technology limitations]
- **Regulatory Constraints**: [Legal, security, or compliance requirements]

### 2.4 Stakeholders
| Role | Name | Interest/Impact |
|------|------|----------------|
| Product Owner | {{Name}} | [Business impact description] |
| Tech Lead | {{Name}} | [Technical impact description] |
| DevOps | {{Name}} | [Operational impact description] |
| Security | {{Name}} | [Security impact description] |
| Users | {{Group}} | [User experience impact] |

---

## 3. Decision Drivers

### 3.1 Key Factors
List the most important factors influencing this decision:

1. **{{Factor 1}}**: [Description and importance level]
2. **{{Factor 2}}**: [Description and importance level]
3. **{{Factor 3}}**: [Description and importance level]
4. **{{Factor 4}}**: [Description and importance level]

### 3.2 Success Criteria
[How will we know if this decision was successful?]

- **Technical Success**: [Measurable technical outcomes]
- **Business Success**: [Measurable business outcomes]
- **User Success**: [Measurable user experience outcomes]
- **Timeline**: [Expected implementation timeline]

---

## 4. Options Considered

### 4.1 Option A: {{Option Name}}
**Description**: [Detailed description of this option]

**Pros**:
- ✅ [Advantage 1]
- ✅ [Advantage 2]
- ✅ [Advantage 3]

**Cons**:
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]
- ❌ [Disadvantage 3]

**Cost/Effort**: [Implementation cost and effort estimate]

**Risk Level**: Low | Medium | High
**Risks**:
- [Risk 1 and mitigation]
- [Risk 2 and mitigation]

### 4.2 Option B: {{Option Name}}
**Description**: [Detailed description of this option]

**Pros**:
- ✅ [Advantage 1]
- ✅ [Advantage 2]
- ✅ [Advantage 3]

**Cons**:
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]
- ❌ [Disadvantage 3]

**Cost/Effort**: [Implementation cost and effort estimate]

**Risk Level**: Low | Medium | High
**Risks**:
- [Risk 1 and mitigation]
- [Risk 2 and mitigation]

### 4.3 Option C: {{Option Name}} (If applicable)
[Follow same format as above]

### 4.4 Option Comparison Matrix

| Criteria | Weight | Option A | Option B | Option C |
|----------|--------|----------|----------|----------|
| Performance | High | 8/10 | 6/10 | 9/10 |
| Maintainability | High | 7/10 | 9/10 | 5/10 |
| Development Speed | Medium | 9/10 | 7/10 | 4/10 |
| Cost | High | 6/10 | 8/10 | 3/10 |
| Risk | High | 7/10 | 9/10 | 5/10 |
| **Weighted Score** | - | **{{X.X}}** | **{{Y.Y}}** | **{{Z.Z}}** |

---

## 5. Decision

### 5.1 Chosen Option
**Selected**: Option {{X}} - {{Option Name}}

### 5.2 Rationale
[Explain why this option was chosen over the alternatives. Reference the decision drivers and comparison matrix.]

Key reasons for this choice:
1. **{{Primary Reason}}**: [Detailed explanation]
2. **{{Secondary Reason}}**: [Detailed explanation]
3. **{{Additional Reason}}**: [Detailed explanation]

### 5.3 Decision Authority
This decision was made by:
- **{{Decision Maker}}** ({{Role}}) - Final authority
- **{{Reviewer}}** ({{Role}}) - Technical review
- **{{Stakeholder}}** ({{Role}}) - Business approval

**Decision Date**: {{YYYY-MM-DD}}
**Approval Method**: [Meeting, async review, etc.]

---

## 6. Consequences

### 6.1 Positive Consequences
- ✅ **{{Benefit 1}}**: [Description of benefit and expected impact]
- ✅ **{{Benefit 2}}**: [Description of benefit and expected impact]
- ✅ **{{Benefit 3}}**: [Description of benefit and expected impact]

### 6.2 Negative Consequences
- ❌ **{{Trade-off 1}}**: [Description of negative impact and mitigation plan]
- ❌ **{{Trade-off 2}}**: [Description of negative impact and mitigation plan]
- ❌ **{{Trade-off 3}}**: [Description of negative impact and mitigation plan]

### 6.3 Neutral Consequences
- ➡️ **{{Change 1}}**: [Description of neutral changes that will occur]
- ➡️ **{{Change 2}}**: [Description of neutral changes that will occur]

---

## 7. Implementation Plan

### 7.1 Implementation Steps
1. **Phase 1** ({{Timeframe}}): [Description of initial phase]
   - [ ] {{Task 1}}
   - [ ] {{Task 2}}
   - [ ] {{Task 3}}

2. **Phase 2** ({{Timeframe}}): [Description of second phase]
   - [ ] {{Task 1}}
   - [ ] {{Task 2}}
   - [ ] {{Task 3}}

3. **Phase 3** ({{Timeframe}}): [Description of final phase]
   - [ ] {{Task 1}}
   - [ ] {{Task 2}}
   - [ ] {{Task 3}}

### 7.2 Resource Requirements
- **Development Team**: {{X}} developers for {{Y}} weeks
- **DevOps Support**: {{Hours}} hours for infrastructure changes
- **Budget**: ${{Amount}} for [tools/services/infrastructure]
- **Training**: {{Hours}} hours for team training on new technology

### 7.3 Dependencies
- **External Dependencies**: [Third-party services, vendor support, etc.]
- **Internal Dependencies**: [Other teams, system changes, etc.]
- **Technical Dependencies**: [Technology adoption, infrastructure changes, etc.]

### 7.4 Success Metrics
| Metric | Target | Measurement Method | Timeline |
|--------|--------|--------------------|----------|
| {{Metric 1}} | {{Target Value}} | {{How to measure}} | {{When to measure}} |
| {{Metric 2}} | {{Target Value}} | {{How to measure}} | {{When to measure}} |
| {{Metric 3}} | {{Target Value}} | {{How to measure}} | {{When to measure}} |

---

## 8. Risks & Mitigation

### 8.1 Implementation Risks
| Risk | Probability | Impact | Mitigation Strategy | Owner |
|------|-------------|--------|-------------------|-------|
| {{Risk 1}} | High/Med/Low | High/Med/Low | [Mitigation plan] | {{Owner}} |
| {{Risk 2}} | High/Med/Low | High/Med/Low | [Mitigation plan] | {{Owner}} |
| {{Risk 3}} | High/Med/Low | High/Med/Low | [Mitigation plan] | {{Owner}} |

### 8.2 Long-term Risks
- **Technical Debt**: [Potential debt accumulation and management plan]
- **Vendor Lock-in**: [Lock-in risks and exit strategies]
- **Skill Dependencies**: [Team skill requirements and training plans]
- **Scalability**: [Future scaling challenges and solutions]

### 8.3 Contingency Plans
- **Plan B**: [What to do if implementation fails]
- **Rollback Strategy**: [How to revert changes if needed]
- **Alternative Paths**: [Other options to pursue if roadblocks occur]

---

## 9. Validation & Monitoring

### 9.1 Validation Criteria
Before considering this ADR successfully implemented:
- [ ] All implementation phases completed
- [ ] Success metrics achieved
- [ ] No critical issues or blockers
- [ ] Stakeholder acceptance obtained
- [ ] Documentation updated

### 9.2 Monitoring Plan
**Monitoring Schedule**: [How often to review decision impact]

**Key Indicators to Watch**:
- {{Indicator 1}}: [What to monitor and threshold values]
- {{Indicator 2}}: [What to monitor and threshold values]
- {{Indicator 3}}: [What to monitor and threshold values]

**Review Schedule**:
- **30 days**: Initial impact assessment
- **90 days**: Full impact evaluation
- **6 months**: Long-term consequence review
- **Annual**: Strategic alignment review

### 9.3 Decision Review Triggers
This decision should be reconsidered if:
- [ ] Success metrics are not met after {{Timeline}}
- [ ] Implementation costs exceed {{Threshold}} over budget
- [ ] Critical risks materialize despite mitigation
- [ ] Business context changes significantly
- [ ] Technology landscape shifts fundamentally

---

## 10. Related Decisions

### 10.1 Dependencies
- **Supersedes**: ADR-{{XXX}} - {{Title}} (if applicable)
- **Depends on**: ADR-{{XXX}} - {{Title}} (if applicable)
- **Related to**: ADR-{{XXX}} - {{Title}} (if applicable)

### 10.2 Impact on Existing ADRs
- **ADR-{{XXX}}**: [How this decision affects the previous decision]
- **ADR-{{YYY}}**: [Impact description]

### 10.3 Future Decisions
This decision may influence:
- [Future architectural choice 1]
- [Future architectural choice 2]
- [Future architectural choice 3]

---

## 11. Communication Plan

### 11.1 Stakeholder Communication
| Stakeholder Group | Communication Method | Key Messages | Timeline |
|-------------------|---------------------|--------------|----------|
| Development Team | [Email/Meeting/Slack] | [Key points for devs] | [When] |
| Product Team | [Email/Meeting/Slack] | [Key points for product] | [When] |
| Leadership | [Email/Meeting/Report] | [Key points for leadership] | [When] |
| Users | [Documentation/Blog] | [Key points for users] | [When] |

### 11.2 Documentation Updates
- [ ] Update architectural documentation
- [ ] Update developer onboarding materials
- [ ] Update deployment procedures
- [ ] Update monitoring and alerting
- [ ] Update disaster recovery plans

### 11.3 Training Plan
- **Target Audience**: [Who needs training]
- **Training Content**: [What they need to learn]
- **Training Method**: [How training will be delivered]
- **Timeline**: [When training will occur]

---

## 12. Lessons Learned

### 12.1 What Went Well
[To be filled after implementation]
- [Positive outcome 1]
- [Positive outcome 2]
- [Positive outcome 3]

### 12.2 What Could Be Improved
[To be filled after implementation]
- [Improvement area 1]
- [Improvement area 2]
- [Improvement area 3]

### 12.3 Recommendations for Future ADRs
[To be filled after implementation]
- [Process improvement 1]
- [Process improvement 2]
- [Process improvement 3]

---

## 13. Appendices

### 13.1 Supporting Documents
- [Link to research documents]
- [Link to proof of concepts]
- [Link to vendor evaluations]
- [Link to technical specifications]

### 13.2 Meeting Notes
- **{{Date}}**: [Link to decision meeting notes]
- **{{Date}}**: [Link to stakeholder review notes]
- **{{Date}}**: [Link to technical review notes]

### 13.3 Code Examples / Prototypes
```{{language}}
// Example code demonstrating the decision
{{code_example}}
```

### 13.4 Architecture Diagrams
[Include or link to relevant architecture diagrams showing before/after states]

---

## 14. Approval & Sign-off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Technical Lead | {{NAME}} | {{DATE}} | [ ] |
| Product Owner | {{NAME}} | {{DATE}} | [ ] |
| Security Lead | {{NAME}} | {{DATE}} | [ ] |
| DevOps Lead | {{NAME}} | {{DATE}} | [ ] |
| Architecture Council | {{NAME}} | {{DATE}} | [ ] |

---

## 15. Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 0.1 | {{DATE}} | {{AUTHOR}} | Initial draft |
| 0.2 | {{DATE}} | {{AUTHOR}} | [Description of changes] |
| 1.0 | {{DATE}} | {{AUTHOR}} | Final approved version |

---

**Document Status**: {{Status}}
**Last Modified**: {{DATE}} by {{AUTHOR}}
**Next Review Date**: {{DATE}}
**Traceability**: Links to FR-{{XXX}}, FS-{{XXX}}, D-{{XXX}}