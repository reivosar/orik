# Spec-Driven Development DSL for Claude
# Framework for Claude to create specifications and implement them

## CORE_PRINCIPLES
- Create specifications that Claude can easily read and understand
- Include all details necessary for implementation in design documents
- Create verifiable implementation plans
- Implement staged quality checks

## DOCUMENT_TEMPLATES

### REQUIREMENTS_TEMPLATE
```
# Requirements Document

## 1. Project Overview
- **Purpose**: [Describe purpose in one line]
- **Target Users**: [Describe intended users]
- **Scope**: [Clarify project scope]

## 2. Functional Requirements
### 2.1 Core Features
- [ ] Feature 1: [Describe specific behavior]
- [ ] Feature 2: [Describe specific behavior]

### 2.2 Non-Functional Requirements
- **Performance**: [Performance requirements]
- **Security**: [Security requirements]
- **Availability**: [Availability requirements]

## 3. Constraints
- [Technical constraints]
- [Time constraints]
- [Resource constraints]

## 4. Success Criteria
- [ ] Criterion 1: [Measurable criterion]
- [ ] Criterion 2: [Measurable criterion]
```

### DESIGN_TEMPLATE  
```
# Design Document

## 1. What to Build
### 1.1 Core Components
#### [ComponentName]
- **Purpose**: [What this component does]
- **Inputs**: [What data/events it receives]
- **Outputs**: [What data/events it produces]
- **Business Logic**: [Core logic this component handles]

### 1.2 Data Flow
1. [User action] → [Component A] → [Data transformation]
2. [Component A] → [Component B] → [Result]
3. [Final output] → [User sees what]

### 1.3 Security Requirements
- **Authentication**: [How users are verified]
- **Authorization**: [What users can access]
- **Data Protection**: [How sensitive data is handled]
- **Input Validation**: [How inputs are validated]

## 2. Component Interactions
### 2.1 Interface Definitions
#### Component A ↔ Component B
- **Method**: [How they communicate]
- **Data Format**: [What data is exchanged]
- **Error Handling**: [How errors are communicated]

## 3. Success Criteria
- [Measurable outcome 1]
- [Measurable outcome 2]
- [Performance criteria]
```

### TASKS_TEMPLATE
```
# Implementation Plan

## Development Tasks

### Setup Phase
- [ ] Task S1: Project Initialization
  - **What**: Set up project structure and dependencies
  - **Files to Create**: package.json, .gitignore, README.md
  - **Dependencies**: None
  - **Done When**: Project builds without errors

### Core Implementation Phase
- [ ] Task C1: [Component Name] Implementation
  - **What**: Build [specific functionality]
  - **Files to Create**: [list specific files]
  - **Files to Modify**: [list files to edit]
  - **Dependencies**: Task S1
  - **Done When**: [specific testable criteria]

- [ ] Task C2: [Integration Task]
  - **What**: Connect [Component A] with [Component B]
  - **Files to Modify**: [integration files]
  - **Dependencies**: Task C1
  - **Done When**: [end-to-end flow works]

### Verification Phase
- [ ] Task V1: Testing Implementation
  - **What**: Verify all requirements are met
  - **Files to Create**: test files
  - **Dependencies**: All C tasks
  - **Done When**: All tests pass and requirements satisfied

## Implementation Order
1. Setup Phase (parallel tasks allowed)
2. Core Implementation Phase (follow dependencies)
3. Verification Phase

## Risk Mitigation
- [Potential risk 1] → [mitigation strategy]
- [Potential risk 2] → [mitigation strategy]
```

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