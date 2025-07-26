# CLAUDE.md - DSL Version

## MANDATORY Process

**Start: Read CLAUDE.md / End: Execute checklist.dsl**

**MANDATORY RULES:**
- Always read CLAUDE.md at task start to confirm latest status
- Execute all checklist items before proceeding to next step  
- Ask questions in Japanese, require Japanese responses
- **Documentation task definition: Documentation creation + All validations passed = Task complete**
- **Task is NOT complete until validation_passed = true**
- **FORBIDDEN: Reporting to user before documentation is complete**

Follow entry-point.dsl for complete DSL execution with modular structure:
- document-rules/: Document creation policies and standards
- workflow-rules/: Scenario classification and workflow management  
- quality-gates/: Validation and quality enforcement
- question-rules/: Intelligent questioning system