# Spec-Driven Development DSL for Claude
# Framework for Claude to create specifications and implement them

## CORE_PRINCIPLES
- Create specifications that Claude can easily read and understand
- Include all details necessary for implementation in design documents
- Create verifiable implementation plans
- Implement staged quality checks

## DOCUMENT_TEMPLATES

Templates are located in the templates/ directory:
- templates/requirements-template.md
- templates/design-template.md  
- templates/tasks-template.md

## CLAUDE_EXECUTION_FLOW

### PHASE_1_REQUIREMENTS
1. Receive user requirements
2. Create requirements.md following REQUIREMENTS_TEMPLATE
3. Request user confirmation and revision
4. Finalize requirements.md

### PHASE_2_DESIGN  
1. Analyze requirements.md in detail
2. Create design.md following DESIGN_TEMPLATE
3. Include all details necessary for implementation
4. Request user confirmation and revision
5. Finalize design.md

### PHASE_3_TASKS
1. Extract specific tasks from design.md
2. Create tasks.md following TASKS_TEMPLATE
3. Include detailed implementation guidelines for each task
4. Clarify dependencies and order
5. Finalize tasks.md

### PHASE_4_IMPLEMENTATION
1. Start implementation following tasks.md order
2. Execute quality checks upon completion of each task
3. Return to previous phase for correction when checks fail
4. Continue until all tasks are completed

## QUALITY_CONTROL
Execute relevant checklist from checklist.dsl at the completion of each phase