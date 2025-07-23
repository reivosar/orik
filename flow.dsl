# Flow DSL for orik Framework
# Controls the 4-phase spec-driven development workflow

## EXECUTION_FLOW

### PHASE_1_REQUIREMENTS
1. Receive user requirements
2. Create requirements.md following templates/requirements-template.md
3. Request user confirmation and revision
4. Finalize requirements.md
5. Execute REQUIREMENTS phase checklist from checklist.dsl

### PHASE_2_DESIGN  
1. Analyze requirements.md in detail
2. Create design.md following templates/design-template.md
3. Include all details necessary for implementation
4. Request user confirmation and revision
5. Finalize design.md
6. Execute DESIGN phase checklist from checklist.dsl

### PHASE_3_TASKS
1. Extract specific tasks from design.md
2. Create tasks.md following templates/tasks-template.md
3. Include detailed implementation guidelines for each task
4. Clarify dependencies and order
5. Finalize tasks.md
6. Execute TASKS phase checklist from checklist.dsl

### PHASE_4_IMPLEMENTATION
1. Start implementation following tasks.md order
2. Execute quality checks upon completion of each task
3. Return to previous phase for correction when checks fail
4. Continue until all tasks are completed
5. Execute IMPLEMENTATION phase checklist from checklist.dsl

## PHASE_TRANSITIONS

### Requirements → Design
- Condition: requirements.md finalized and approved
- Trigger: User confirms requirements are complete

### Design → Tasks  
- Condition: design.md finalized and approved
- Trigger: User confirms design is complete

### Tasks → Implementation
- Condition: tasks.md finalized and approved
- Trigger: User confirms implementation plan is complete

### Error Recovery
- Any phase failure → Return to that phase
- Quality check failure → Return to previous phase
- User feedback → Revise current phase