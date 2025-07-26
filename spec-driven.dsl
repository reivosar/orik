variables:
  document_structure:
    base_path: docs/
    template_path: templates/
    generated_path: docs/generated/
    
  versioning_policy:
    strategy: directory_based
    latest_symlink: true
    auto_increment: true
    
  file_naming:
    requirements: requirements.md
    feature_specs: "FS-{id}-{slug}.md"
    design: design.md
    tasks: tasks.md
    test_specs: test-spec.md
    trace: trace.md
    adr: "ADR-{id}-{slug}.md"

components:
  development_scenarios:
    new_product: Complete new product or major feature development
    major_feature: Medium-scale feature addition
    ui_change: Small UI changes or copy updates
    bug_fix: Bug fixes (behavior not matching specs)
    spec_change: Specification changes (modifying AC)
    refactor: Refactoring/internal optimization only
    infra_perf: Infrastructure/performance improvements
    default: spec_change
  
  scenario_classifier:
    questions: [
      Does this change affect user experience? (UI/copy/functionality),
      Does internal structure/data/public API change?,
      Are new tasks required?,
      Does this involve important architectural decisions?
    ]
  
  document_requirements:
    new_product:
      fr: create
      fs: create
      design: create
      tasks: create
      test_spec: create
      trace: create
      adr: note
    major_feature:
      fr: revise
      fs: revise
      design: revise
      tasks: revise
      test_spec: revise
      trace: update
      adr: note
    ui_change:
      fr: revise
      fs: revise
      design: skip
      tasks: create
      test_spec: create
      trace: update
    bug_fix:
      fr: reference
      fs: skip
      design: skip
      tasks: create
      test_spec: create
      trace: update
    spec_change:
      fr: revise
      fs: revise
      design: revise
      tasks: revise
      test_spec: revise
      trace: update
      adr: note
    refactor:
      fr: skip
      fs: skip
      design: note
      tasks: create
      test_spec: note
      trace: update
      adr: note
    infra_perf:
      fr: skip
      nfr: create
      fs: skip
      design: revise
      tasks: create
      test_spec: create
      trace: update
      adr: note

rules:
  - name: template_usage
    description: Always use templates from templates/
    enforce: true
    
  - name: version_increment
    description: Create new version directory for major changes
    condition: "scenario in [new_product, major_feature, spec_change]"
    
  - name: latest_symlink_update
    description: Update latest.md symlink after document creation
    enforce: true
    
  - name: trace_regeneration
    description: Regenerate trace.md after any document changes
    enforce: true

flow:
  - action: load_external
    files: [
      document-rules/creation-policy.dsl,
      question-rules/scenario-questions.dsl,
      workflow-rules/scenario-classification.dsl
    ]
  
  - action: initialize_document_structure
    with:
      base_path: "${variables.document_structure.base_path}"
      ensure_directories: [requirements, fs, design, tasks, tests/spec, trace, generated]
  
  - action: classify_development_scenario
    with:
      questions: "${components.scenario_classifier.questions}"
      scenarios: "${components.development_scenarios}"
      allow_multiple: true
    as: scenario
  
  - action: assess_impact
    with:
      criteria: [user_facing, architecture, risk_scale]
    as: impact_result
  
  - action: ask_scenario_questions
    with:
      scenario: "${scenario}"
      question_source: question-rules/scenario-questions.dsl
    as: detailed_requirements
  
  - action: determine_required_documents
    with:
      scenario: "${scenario}"
      requirements: "${components.document_requirements[scenario]}"
      priority_order: [create, revise, update, reference, note, skip]
    as: doc_plan
  
  - action: confirm_document_plan
    with:
      message: |
        Development scenario: ${scenario}
        Requirements gathered: ${detailed_requirements}
        Required documents: ${doc_plan.required}
        Conditional: ${doc_plan.conditional}
        Skip: ${doc_plan.skip}
        
        Proceed with this plan?
    as: user_response
  
  - if: user_response != yes
    then:
      - action: halt
        message: Please review the document plan
  
  - action: execute_document_workflow
    with:
      scenario: "${scenario}"
      doc_plan: "${doc_plan}"
      requirements_input: "${detailed_requirements}"
      creation_policy: document-rules/creation-policy.dsl
  
  - action: validate_traceability
    with:
      target: trace.md
      threshold: {coverage: 1.0, orphan_allowed: 0}
    on_failure:
      goto: execute_document_workflow
  
  - action: present_completion_checklist
    with:
      checklist_ref: "${scenario}"
      resolve: scenario_specific_checklists
      
  - action: finalize_documents
    with:
      update_symlinks: true
      regenerate_trace: true
      validate_structure: true

validation:
  pre_creation:
    - check_template_availability
    - validate_directory_structure
    - ensure_permissions
    
  post_creation:
    - validate_document_format
    - check_id_consistency
    - verify_traceability
    - update_latest_symlinks
    - regenerate_trace_matrix