# Checklist DSL for orik Framework
# Quality checks and error recovery checklist

## QUALITY_GATES

### DOCUMENT_QUALITY_CHECK
- Are documents specific and implementable?
- Are there no ambiguous or unclear specifications?
- Is the detail level sufficient for Claude to understand and implement?
- Are application type-specific requirements included?
- Are security requirements organized by priority?

### IMPLEMENTATION_QUALITY_CHECK  
- Are all defined deliverables created?
- Are all completion conditions satisfied?
- Are prerequisites for next tasks ready?
- Is syntax checking completed?
- Is basic functionality testing completed?
- Is error handling implemented?

### PHASE_COMPLETION_CHECK
#### Requirements Phase
- [ ] Functional requirements are clearly defined
- [ ] Non-functional requirements are included
- [ ] Success criteria are measurable
- [ ] Constraints are documented

#### Design Phase  
- [ ] Architecture is clear
- [ ] File structure is defined
- [ ] Data flow is explained
- [ ] Error handling strategy exists
- [ ] Testing strategy is included

#### Tasks Phase
- [ ] Tasks are specific and executable
- [ ] Each task has completion criteria
- [ ] Dependencies are clear
- [ ] Time estimates are provided

#### Implementation Phase
- [ ] All tasks are completed
- [ ] Code syntax check completed
- [ ] Basic functionality test completed
- [ ] Error handling implementation completed
- [ ] All features verification completed

## ERROR_RECOVERY

### RECOVERY_ACTIONS
- Return to relevant phase when quality check fails
- Re-execute subsequent phases after document revision
- Start from tasks.md review when implementation errors occur

### ROLLBACK_CONDITIONS
- Requirements issues → Return to Requirements Phase
- Design issues → Return to Design Phase  
- Tasks issues → Return to Tasks Phase
- Implementation failure → Resume from relevant task

## FINAL_CHECKLIST
- [ ] Project requirements are satisfied
- [ ] All features work correctly
- [ ] Error handling is appropriate
- [ ] Documentation is completed
- [ ] Tests are passing