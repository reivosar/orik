claude_dsl:
  version: "0.4"
  description: "Complete spec-driven development controller with integrated workflow"
  
  variables:
    document_structure:
      base_path: "docs/"
      template_path: "docs/_templates/"
      generated_path: "docs/generated/"
      
    versioning_policy:
      strategy: "directory_based"  # v0.1/, v0.2/, etc.
      latest_symlink: true        # latest.md -> v0.x/document.md
      auto_increment: true        # Auto-detect next version
      
    file_naming:
      requirements: "requirements.md"           # or FR-001.md for split
      feature_specs: "FS-{id}-{slug}.md"       # FS-001-login-form.md
      design: "design.md"                      # or D-001.md for components
      tasks: "tasks.md"                        # T-xxx embedded
      test_specs: "test-spec.md"               # TC-xxx embedded
      trace: "trace.md"                        # Auto-generated
      adr: "ADR-{id}-{slug}.md"                # ADR-001-database-choice.md

  components:
    document_creation_policy:
      load_from: "document-creation-policy.dsl"
      
    quality_gates:
      load_from: "checklist.dsl"
      
    questioning_framework:
      load_from: "questions.dsl"
      
    # Integrated workflow components from flow.dsl
    development_scenarios:
      new_product: "Complete new product or major feature development"
      major_feature: "Medium-scale feature addition"
      ui_change: "Small UI changes or copy updates"
      bug_fix: "Bug fixes (behavior not matching specs)"
      spec_change: "Specification changes (modifying AC)"
      refactor: "Refactoring/internal optimization only"
      infra_perf: "Infrastructure/performance improvements"
      default: "spec_change"
    
    scenario_classifier:
      questions:
        - "Does this change affect user experience? (UI/copy/functionality)"
        - "Does internal structure/data/public API change?"
        - "Are new tasks required?"
        - "Does this involve important architectural decisions?"
    
    document_requirements:
      new_product: {fr: create, fs: create, design: create, tasks: create, test_spec: create, trace: create, adr: note, sdp: skip}
      major_feature: {fr: revise, fs: revise, design: revise, tasks: revise, test_spec: revise, trace: update, adr: note, sdp: skip}
      ui_change: {fr: revise, fs: revise, design: skip, tasks: create, test_spec: create, trace: update, adr: skip, sdp: skip}
      bug_fix: {fr: reference, fs: skip, design: skip, tasks: create, test_spec: create, trace: update, adr: skip, sdp: skip}
      spec_change: {fr: revise, fs: revise, design: revise, tasks: revise, test_spec: revise, trace: update, adr: note, sdp: skip}
      refactor: {fr: skip, fs: skip, design: note, tasks: create, test_spec: note, trace: update, adr: note, sdp: skip}
      infra_perf: {fr: skip, nfr: create, fs: skip, design: revise, tasks: create, test_spec: create, trace: update, adr: note, sdp: skip}

  rules:
    - name: "template_usage"
      description: "Always use templates from docs/_templates/"
      enforce: true
      
    - name: "version_increment"  
      description: "Create new version directory for major changes"
      condition: "scenario in ['new_product', 'major_feature', 'spec_change']"
      
    - name: "latest_symlink_update"
      description: "Update latest.md symlink after document creation"
      enforce: true
      
    - name: "trace_regeneration"
      description: "Regenerate trace.md after any document changes"
      enforce: true
      
    - name: "generated_readonly"
      description: "Never manually edit files in docs/generated/"
      enforce: true

  flow:
    - action: load_policies
      with:
        policies: ["document-creation-policy.dsl", "questions.dsl", "checklist.dsl"]
    
    - action: initialize_document_structure
      with:
        base_path: "${variables.document_structure.base_path}"
        ensure_directories: ["requirements", "fs", "design", "tasks", "tests/spec", "trace", "generated"]
    
    # Complete integrated workflow (formerly flow.dsl)
    - action: set_vars
      with:
        issue_id: "${args.issue_id}"
        fr_id: "${args.fr_id}"
        component: "${args.component}"
        bug_id: "${args.bug_id}"
    
    - action: classify_development_scenario
      with:
        questions: "${components.scenario_classifier.questions}"
        scenarios: "${components.development_scenarios}"
        allow_multiple: true
      as: scenario
    
    - action: assess_impact
      with:
        criteria: ["user_facing", "architecture", "risk_scale"]
      as: impact_result
    
    - action: ask_scenario_questions
      with:
        scenario: "${scenario}"
        question_source: "questions.dsl"
      as: detailed_requirements
    
    - action: determine_required_documents
      with:
        scenario: "${scenario}"
        requirements: "${components.document_requirements[scenario]}"
        priority_order: ["create", "revise", "update", "reference", "note", "skip"]
      as: doc_plan
    
    - action: confirm_document_plan
      with:
        message: |
          "Development scenario: ${scenario}
          Requirements gathered: ${detailed_requirements}
          Required documents: ${doc_plan.required}
          Conditional: ${doc_plan.conditional}
          Skip: ${doc_plan.skip}
          
          Proceed with this plan?"
      as: user_response
    
    - if: user_response != "yes"
      then:
        - action: halt
          message: "Please review the document plan"
    
    - action: execute_document_workflow
      with:
        scenario: "${scenario}"
        doc_plan: "${doc_plan}"
        requirements_input: "${detailed_requirements}"
        creation_policy: "document-creation-policy.dsl"
    
    - action: validate_traceability
      with:
        target: "trace.md"
        threshold: {coverage: 1.0, orphan_allowed: 0}
      on_failure:
        goto: "execute_document_workflow"
    
    - action: present_completion_checklist
      with:
        checklist_ref: "${scenario}"
        resolve: "scenario_specific_checklists"
        
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

  automation:
    make_commands:
      new_feature: "Generate complete document set for new feature"
      change_spec: "Update specifications with cascade"
      fix_bug: "Create bug fix documentation"
      trace_update: "Regenerate traceability matrix"
      
    ci_integration:
      validate_generated_readonly: true
      check_symlink_consistency: true
      verify_trace_accuracy: true