variables:
  quality_thresholds:
    document_completeness: 100%
    traceability_coverage: 100%
    template_compliance: 100%
    cross_reference_validity: 100%

components:
  document_quality_gates:
    specificity_check: [
      Are documents specific and implementable?,
      Are there no ambiguous or unclear specifications?,
      Is the detail level sufficient for implementation?,
      Are application type-specific requirements included?
    ]
    
    completeness_check: [
      Are all defined deliverables created?,
      Are all completion conditions satisfied?,
      Are prerequisites for next tasks ready?,
      Are all template sections filled?
    ]
  
  phase_completion_gates:
    requirements_phase: [
      Functional requirements are clearly defined,
      Non-functional requirements are included,
      Success criteria are measurable,
      Constraints are documented
    ]
    
    design_phase: [
      Architecture is clear,
      Component structure is defined,
      Data flow is explained,
      Integration points are specified,
      Testing strategy is included
    ]
    
    tasks_phase: [
      Tasks are specific and executable,
      Each task has completion criteria,
      Dependencies are clear,
      Time estimates are provided
    ]
    
    documentation_phase: [
      All required documents are created,
      Template compliance is verified,
      Cross-references are valid,
      Traceability matrix is complete
    ]
  
  error_recovery:
    recovery_actions: [
      Return to relevant phase when quality check fails,
      Re-execute subsequent phases after document revision,
      Start from document review when errors occur
    ]
    
    rollback_conditions:
      requirements_issues: Return to Requirements Phase
      design_issues: Return to Design Phase
      tasks_issues: Return to Tasks Phase
      documentation_failure: Resume from relevant document
  
  final_validation: [
    Project requirements are satisfied,
    All documentation is complete,
    Quality gates are passed,
    Traceability is verified,
    User acceptance is confirmed
  ]

rules:
  - if: any_quality_gate_fails
    then:
      action: halt_and_remediate
      target: failed_gate_phase
  
  - if: all_gates_pass
    then:
      action: proceed_to_completion
      validation: mark_validation_passed_true

flow:
  - action: validate_document_quality
    with:
      gates: "${components.document_quality_gates}"
    on_failure:
      goto: error_recovery
  
  - action: validate_phase_completion
    with:
      phases: "${components.phase_completion_gates}"
    on_failure:
      goto: error_recovery
  
  - action: execute_final_validation
    with:
      checklist: "${components.final_validation}"
    on_success:
      set_variable: validation_passed = true
  
  - action: confirm_completion
    with:
      message: All quality gates passed. Documentation workflow complete.
    required: true