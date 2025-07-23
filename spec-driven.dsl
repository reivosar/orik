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

## 1. Architecture Overview
- **Application Type**: [Web/CLI/Desktop/API/Library/Mobile/Microservice/Batch etc.]
- **Architecture Pattern**: [MVC/Layered/Microservices/Event-Driven etc.]
- **Tech Stack**: [List of technologies used]

### 1.1 Application Type Requirements
[Application-specific requirements based on type]

### 1.2 Security Requirements
[Security requirements organized by priority]

## 2. System Design
### 2.1 Directory Structure
```
project/
├── src/
│   ├── components/
│   ├── services/
│   └── utils/
├── tests/
└── docs/
```

### 2.2 Core Components
#### ComponentA
- **Responsibility**: [Component role]
- **Interface**: [API definition]
- **Dependencies**: [Relationships with other components]

### 2.3 Data Flow
1. [Step 1 details]
2. [Step 2 details]
3. [Step 3 details]

## 3. Implementation Details
### 3.1 File-specific Implementation
- `src/main.js`: [Implementation content for this file]
- `src/utils.js`: [Implementation content for this file]


```

### TASKS_TEMPLATE
```
# Implementation Tasks

## Task List

### Phase 1: Foundation Setup
- [ ] Task 1.1: Project Initialization
  - **Details**: Create package.json, install dependencies
  - **Deliverables**: `package.json`, `node_modules/`
  - **Duration**: 5 minutes
  - **Completion Criteria**: npm install executes successfully

### Phase 2: Core Feature Implementation
- [ ] Task 2.1: [Specific task name]
  - **Details**: [Implementation details]
  - **Files**: [List of files to create/edit]
  - **Deliverables**: [Specific files/features to be created]
  - **Dependencies**: [Prerequisite tasks]
  - **Completion Criteria**: [Testable completion criteria]

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