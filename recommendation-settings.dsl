claude_dsl:
  version: "0.1"
  description: "Recommendation settings for system policies and scenario-specific defaults"
  
  variables:
    recommendation_source:
      system_policy: "Use organization-wide design policies and standards"
      project_specific: "Define per-project recommendations"
      hybrid: "System policy as base, project overrides allowed"
  
  components:
    system_policies:
      # These would be loaded from system-design-policy-template.md
      architecture:
        default_patterns: ["MVC", "Repository Pattern", "Service Layer"]
        api_standards: "RESTful with OpenAPI 3.0 specification"
        error_handling: "Centralized error handler with correlation IDs"
        logging: "Structured JSON logging with ELK stack"
      
      coding_standards:
        naming_conventions: "camelCase for functions, PascalCase for classes"
        file_organization: "Feature-based folder structure"
        testing_approach: "TDD with minimum 80% coverage"
        documentation: "JSDoc for all public APIs"
      
      infrastructure:
        deployment: "Kubernetes with GitOps"
        monitoring: "Prometheus + Grafana"
        ci_cd: "GitHub Actions with quality gates"
        security: "OWASP Top 10 compliance"
      
      performance:
        slo_defaults:
          api_response_p95: "< 200ms"
          page_load_lcp: "< 2.5s"
          error_rate: "< 0.1%"
          availability: "99.9%"
    
    scenario_recommendations:
      bug_fix:
        # These MUST be provided by user - cannot be guessed
        required_from_user:
          - current_behavior: "What is the actual bug behavior?"
          - affected_feature: "Which feature/component is broken?"
          - affected_ac_id: "Which acceptance criteria ID?"
        
        # These can be recommended based on context
        recommendable:
          correct_behavior: "${lookup.acceptance_criteria(context.affected_ac_id)}"
          suggested_tasks:
            - "Reproduce bug in test environment"
            - "Debug and identify root cause"
            - "Implement fix"
            - "Add regression test"
            - "Verify fix in staging"
      
      ui_change:
        required_from_user:
          - affected_components: "Which UI components are changing?"
          - change_description: "What specific UI changes?"
        
        recommendable:
          ui_states: ["Loading", "Error", "Success", "Empty", "Disabled"]
          interaction_flow: "${analyze.user_flow(context.feature)}"
          responsive_breakpoints: "${system_policies.ui.breakpoints}"
          accessibility: "${system_policies.accessibility.standard}"
      
      performance:
        required_from_user:
          - performance_issue: "What performance metric is failing?"
          - current_value: "What is the current measured value?"
          - bottleneck: "Where is the bottleneck?"
        
        recommendable:
          target_value: "${system_policies.performance.slo_defaults[context.metric_type]}"
          measurement_method: "${system_policies.performance.tools[context.metric_type]}"
          suggested_solutions: "${analyze.performance_solutions(context.bottleneck)}"
      
      new_feature:
        required_from_user:
          - feature_description: "What is the new feature?"
          - user_stories: "What are the user goals?"
          - business_value: "What business problem does this solve?"
        
        recommendable:
          acceptance_criteria: "${generate.acceptance_criteria(context.requirements)}"
          technical_components: "${analyze.required_components(context.feature)}"
          architecture_pattern: "${system_policies.architecture.default_patterns}"
          testing_approach: "${system_policies.testing.approach}"
      
      major_feature:
        required_from_user:
          - feature_scope: "What is the scope of this feature?"
          - affected_systems: "Which existing systems are affected?"
          - integration_needs: "What integrations are required?"
        
        recommendable:
          requirements_update: "${analyze.requirement_changes(context.feature)}"
          design_impact: "${analyze.design_impact(context.feature)}"
          migration_strategy: "${generate.migration_plan(context.changes)}"
          risk_assessment: "Medium to High - requires careful planning"
      
      spec_change:
        required_from_user:
          - change_description: "What specifications are changing?"
          - changed_ac_ids: "Which AC IDs are affected?"
          - reason_for_change: "Why is this change needed?"
        
        recommendable:
          change_type: "${classify.spec_change(context.change_description)}"
          impacted_documents: "${analyze.document_cascade(context.changed_ac_ids)}"
          backward_compatibility: "${analyze.compatibility(context.changes)}"
          migration_required: "${determine.migration_needs(context.changes)}"
      
      refactor:
        required_from_user:
          - debt_description: "What technical debt is being addressed?"
          - refactor_scope: "What is the scope of refactoring?"
          - expected_benefits: "What improvements are expected?"
        
        recommendable:
          improvement_goals: "Maintainability, testability, performance"
          risk_assessment: "${analyze.refactor_risk(context.scope)}"
          testing_strategy: "Comprehensive regression testing required"
          performance_gains: "${estimate.performance_improvement(context.changes)}"
      
      infra_perf:
        required_from_user:
          - infrastructure_needs: "What infrastructure changes are needed?"
          - performance_goals: "What performance targets?"
          - expected_load: "What is the expected load/scale?"
        
        recommendable:
          performance_targets: "${system_policies.performance.slo_defaults}"
          monitoring_setup: "${system_policies.infrastructure.monitoring}"
          capacity_planning: "${analyze.capacity_needs(context.expected_load)}"
          nfr_categories: ["Performance", "Scalability", "Reliability"]

  rules:
    - name: "determine_recommendation_source"
      description: "Ask user whether to use system policies or define custom"
      prompt: |
        "Would you like to:
        1. Use system-wide design policies (recommended for consistency)
        2. Define project-specific recommendations
        3. Use system policies with project overrides
        
        Choice [1-3]:"
    
    - name: "load_system_policies"
      condition: "choice in [1, 3]"
      action: "load_from_system_design_policy"
    
    - name: "apply_recommendations"
      description: "Generate recommendations based on context and policies"
      steps:
        1: "Load relevant system policies"
        2: "Analyze project context"
        3: "Generate specific recommendations"
        4: "Present for user confirmation"

  flow:
    - action: ask_recommendation_preference
      with:
        prompt: "${rules.determine_recommendation_source.prompt}"
      as: preference
    
    - if: preference == "1"
      then:
        - action: use_system_policies
          with:
            source: "system-design-policy-template.md"
    
    - if: preference == "2"
      then:
        - action: define_custom_recommendations
          with:
            wizard: true
    
    - if: preference == "3"
      then:
        - action: use_hybrid_approach
          with:
            base: "system-design-policy-template.md"
            overrides: "project-specific"

  integration:
    with_questions_dsl:
      - "Load recommendation settings before generating questions"
      - "Use recommendations to pre-fill answers"
      - "Allow user to modify recommendations"
    
    with_system_design_policy:
      - "Import coding standards"
      - "Import architecture patterns"
      - "Import infrastructure requirements"
      - "Import performance SLOs"