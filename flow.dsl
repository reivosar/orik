claude_dsl:
  version: "0.6"
  variables:
    docs:
      - fr
      - nfr
      - fs
      - design
      - tasks
      - test_spec
      - trace
      - adr
      - sdp
    
    verbs: [create, revise, update, skip, reference, note]
    
    verb_priority: [create, revise, update, reference, note, skip]  # Merge priority order
    
    phase_labels:
      PHASE_1_CLASSIFY: "classify_development_scenario"
      PHASE_2_ASSESS: "assess_impact"
      PHASE_3_PLAN: "determine_required_documents"
      PHASE_4_TASKS: "execute_document_workflow"
      PHASE_5_VALIDATE: "validate_traceability"
      PHASE_6_CHECKLIST: "present_completion_checklist"
    
    traceability_thresholds:
      coverage: 1.0  # 100% coverage required
      orphan_allowed: 0  # No orphan documents
      
    development_scenarios:
      new_product: "Complete new product or major feature development"
      major_feature: "Medium-scale feature addition"
      ui_change: "Small UI changes or copy updates"
      bug_fix: "Bug fixes (behavior not matching specs)"
      spec_change: "Specification changes (modifying AC)"
      refactor: "Refactoring/internal optimization only"
      infra_perf: "Infrastructure/performance improvements"
      default: "spec_change"  # Fallback for unknown scenarios
    
    impact_assessment:
      user_facing: "Does user-visible behavior change (UI/copy/specs)"
      architecture: "Does it affect structure/architecture (API/data/modules)"
      risk_scale: "Risk/scale (duration, team size, failure impact)"

  components:
    scenario_classifier:
      questions:
        - "Does this change affect user experience? (UI/copy/functionality)"
        - "Does internal structure/data/public API change?"
        - "Are new tasks required?"
        - "Does this involve important architectural decisions?"
    
    document_requirements:
      new_product:
        fr: create
        fs: create
        design: create 
        tasks: create
        test_spec: create
        trace: create
        adr: note
        sdp: skip
      
      major_feature:
        fr: revise
        fs: revise
        design: revise
        tasks: revise
        test_spec: revise
        trace: update
        adr: note
        sdp: skip
      
      ui_change:
        fr: revise
        fs: revise
        design: skip
        tasks: create
        test_spec: create
        trace: update
        adr: skip
        sdp: skip
      
      bug_fix:
        fr: reference
        fs: skip
        design: skip
        tasks: create
        test_spec: create
        trace: update
        adr: skip
        sdp: skip
      
      spec_change:
        fr: revise
        fs: revise
        design: revise
        tasks: revise
        test_spec: revise
        trace: update
        adr: note
        sdp: skip
      
      refactor:
        fr: skip
        fs: skip
        design: note
        tasks: create
        test_spec: note
        trace: update
        adr: note
        sdp: skip
      
      infra_perf:
        fr: skip
        nfr: create
        fs: skip
        design: revise
        tasks: create
        test_spec: create
        trace: update
        adr: note
        sdp: skip

  rules:
    - if: scenario == "new_product"
      then:
        use: components.document_requirements.new_product
        action: create_full_documentation
        message: "Creating all documents for new product development"
        checklist: scenario_specific_checklists.new_product
    
    - if: scenario == "major_feature"
      then:
        use: components.document_requirements.major_feature
        action: update_affected_documentation
        message: "Updating affected documents for major feature addition"
        checklist: scenario_specific_checklists.major_feature
    
    - if: scenario == "ui_change"
      then:
        use: components.document_requirements.ui_change
        action: update_ui_specifications
        message: "Updating FS and tasks for UI changes"
        checklist: scenario_specific_checklists.ui_change
    
    - if: scenario == "bug_fix"
      then:
        use: components.document_requirements.bug_fix
        action: create_fix_tasks
        message: "Creating tasks only for bug fix"
        checklist: scenario_specific_checklists.bug_fix
    
    - if: scenario == "spec_change"
      then:
        use: components.document_requirements.spec_change
        action: update_requirements_cascade
        message: "Updating requirements and related documents for spec change"
        checklist: scenario_specific_checklists.spec_change
    
    - if: scenario == "refactor"
      then:
        use: components.document_requirements.refactor
        action: create_technical_tasks
        message: "Creating technical tasks for refactoring"
        checklist: scenario_specific_checklists.refactor
    
    - if: scenario == "infra_perf"
      then:
        use: components.document_requirements.infra_perf
        action: update_nfr_and_design
        message: "Updating NFR and design for infrastructure/performance improvements"
        checklist: scenario_specific_checklists.infra_perf
        
    - else:
      then:
        use: components.document_requirements.spec_change
        action: fallback_to_default
        message: "Unknown scenario, defaulting to spec_change workflow"
        checklist: scenario_specific_checklists.spec_change

  flow:
    - action: set_vars
      with:
        issue_id: "${args.issue_id}"
        fr_id: "${args.fr_id}"
        component: "${args.component}"
        bug_id: "${args.bug_id}"
    
    - action: classify_development_scenario
      with:
        questions: "${components.scenario_classifier.questions}"
        scenarios: "${variables.development_scenarios}"
        allow_multiple: true  # Support composite scenarios
      as: scenario
    
    - action: assess_impact
      with:
        criteria: "${variables.impact_assessment}"
      as: impact_result
    
    - action: determine_required_documents
      with:
        scenario: "${scenario}"
        requirements: "${components.document_requirements[scenario]}"
        verbs: "${variables.verbs}"
        merge_composite: true  # Handle scenario arrays
        priority_order: "${variables.verb_priority}"  # create > revise > update > reference > note > skip
      as: doc_plan  # { required: [...], conditional: [...], skip: [...] }
    
    - action: confirm_document_plan
      with:
        message: |
          "Development scenario: ${scenario}
          Required: ${doc_plan.required}
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
    
    - action: validate_traceability
      with:
        target: "trace.md"
        threshold: "${variables.traceability_thresholds}"
      on_failure:
        goto: "${variables.phase_labels.PHASE_4_TASKS}"
    
    - action: present_completion_checklist
      with:
        checklist_ref: "${scenario}"
        resolve: "scenario_specific_checklists"  # Resolve reference at runtime
        runtime_vars:  # Variables computed by runner for expr evaluation
          trace_coverage: "Calculated coverage percentage from trace.md"
          orphan_count: "Count of orphaned document references"
          baseline_coverage: "Previous test coverage percentage"
          fr_conflicts: "Count of conflicting functional requirements"
          design_updates_complete: "Boolean: all referenced D docs updated"
          adr_created_for_note_items: "Boolean: ADR exists for note-marked decisions"
          ci_gates_configured: "Boolean: CI includes required quality gates"
          fs_ui_specs_concrete: "Boolean: FS contains specific UI specifications"
          wcag_compliance_documented: "Boolean: accessibility requirements documented"
          breakpoint_specs_included: "Boolean: responsive design breakpoints defined"
          ac_references_valid: "Boolean: all AC references exist and current"
          task_dod_measurable: "Boolean: tasks have quantifiable completion criteria"
          regression_tests_present: "Boolean: test cases cover bug scenarios"
          change_rationale_documented: "Boolean: change reasons explicitly documented"
          dependent_docs_updated: "Boolean: all cascade updates complete"
          stakeholder_approval_recorded: "Boolean: approvals in document history"
          improvement_targets_measurable: "Boolean: quantifiable improvement goals"
          api_compatibility_verified: "Boolean: external API compatibility checked"
          before_after_metrics_defined: "Boolean: performance metrics baseline set"
          nfr_targets_quantitative: "Boolean: NFR requirements have numeric targets"
          architecture_review_completed: "Boolean: technical review process complete"
          monitoring_setup_documented: "Boolean: monitoring configuration specified"

  scenario_specific_checklists:
    new_product:
      - id: "nfr_001"
        check: "Are all FR/FS/D/T created and cross-linked?"
        expr: "trace_coverage >= ${variables.traceability_thresholds.coverage}"
      - id: "nfr_002"
        check: "Are important architectural decisions recorded in ADR?"
        expr: "adr_created_for_note_items == true"
      - id: "nfr_003"
        check: "Is there complete mapping in trace.md?"
        expr: "orphan_count <= ${variables.traceability_thresholds.orphan_allowed}"
      - id: "nfr_004"
        check: "Are all quality gates configured in CI?"
        expr: "ci_gates_configured == true"
    
    major_feature:
      - id: "mjf_001"
        check: "Is consistency maintained with existing FR?"
        expr: "fr_conflicts == 0"
      - id: "mjf_002"
        check: "Are design updates for affected areas complete?"
        expr: "design_updates_complete == true"
      - id: "mjf_003"
        check: "Is trace.md update complete?"
        expr: "trace_coverage >= ${variables.traceability_thresholds.coverage}"
      - id: "mjf_004"
        check: "Is test coverage maintained?"
        expr: "test_coverage >= baseline_coverage"
    
    ui_change:
      - id: "ui_001"
        check: "Are UI specifications in FS specifically updated?"
        expr: "fs_ui_specs_concrete == true"
      - id: "ui_002"
        check: "Are accessibility requirements verified?"
        expr: "wcag_compliance_documented == true"
      - id: "ui_003"
        check: "Is responsive design documented?"
        expr: "breakpoint_specs_included == true"
    
    bug_fix:
      - id: "bug_001"
        check: "Are existing AC references correctly documented?"
        expr: "ac_references_valid == true"
      - id: "bug_002"
        check: "Is DoD for fix tasks clearly defined?"
        expr: "task_dod_measurable == true"
      - id: "bug_003"
        check: "Are regression tests included?"
        expr: "regression_tests_present == true"
    
    spec_change:
      - id: "spec_001"
        check: "Are change reasons and impact clear?"
        expr: "change_rationale_documented == true"
      - id: "spec_002"
        check: "Are all cascade updates complete?"
        expr: "dependent_docs_updated == true"
      - id: "spec_003"
        check: "Is stakeholder approval obtained?"
        expr: "stakeholder_approval_recorded == true"
    
    refactor:
      - id: "ref_001"
        check: "Are technical debt resolution goals clear?"
        expr: "improvement_targets_measurable == true"
      - id: "ref_002"
        check: "Is it confirmed that external specs are unaffected?"
        expr: "api_compatibility_verified == true"
      - id: "ref_003"
        check: "Are performance improvements quantitatively measurable?"
        expr: "before_after_metrics_defined == true"
    
    infra_perf:
      - id: "inf_001"
        check: "Are NFR requirements quantitatively defined?"
        expr: "nfr_targets_quantitative == true"
      - id: "inf_002"
        check: "Is performance design technically sound?"
        expr: "architecture_review_completed == true"
      - id: "inf_003"
        check: "Are monitoring and alert configurations included?"
        expr: "monitoring_setup_documented == true"

  automation_hooks:
    on_requirements_change:
      - action: validate_fs_design_consistency
        on_failure: "Return to FS revision"
        trigger: "orik flow run --scenario spec_change --target ${fr_id}"
      - action: check_trace_matrix_update
        on_failure: "Return to trace update"
      - action: notify_stakeholders
        on_failure: "Log notification failure, continue"
    
    on_design_change:
      - action: validate_implementation_feasibility
        on_failure: "Return to design revision"
      - action: check_api_compatibility
        on_failure: "Create ADR for breaking changes"
      - action: update_trace_matrix
        on_failure: "Return to trace update"
    
    on_trace_update:
      - action: validate_completeness
        on_failure: "Return to missing document creation"
      - action: generate_coverage_report
        on_failure: "Log warning, continue"
      - action: update_ci_gates
        on_failure: "Log warning, continue"
    
    make_commands:
      trigger_mapping:
        new_feature: "orik flow run --scenario new_product --issue ${issue_id}"
        change_spec: "orik flow run --scenario spec_change --target ${fr_id}"
        fix_bug: "orik flow run --scenario bug_fix --issue ${bug_id}"
        refactor: "orik flow run --scenario refactor --target ${component}"
      
      templates:
        new_feature: "Auto-create FR→FS→D→T templates"
        change_spec: "Generate target FS/D diff templates"
        fix_bug: "Generate bug fix task templates"
        refactor: "Generate technical debt resolution task templates"
      
      variable_requirements:
        issue_id: "GitHub issue ID or ticket number"
        fr_id: "Functional requirement ID (FR-xxx)"
        component: "Target component/module name"
        bug_id: "Bug report ID or issue number"