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
        current_behavior: "${context.bug_description}"
        correct_behavior: "${lookup.acceptance_criteria(context.affected_feature)}"
        affected_ac: "${context.affected_ac_id}"
        suggested_tasks:
          - "Reproduce bug in test environment"
          - "Debug and identify root cause"
          - "Implement fix"
          - "Add regression test"
          - "Verify fix in staging"
      
      ui_change:
        ui_components: "${context.affected_components}"
        ui_states: ["Loading", "Error", "Success", "Empty", "Disabled"]
        interaction_flow: "${analyze.user_flow(context.feature)}"
        responsive_breakpoints: "${system_policies.ui.breakpoints}"
        accessibility: "${system_policies.accessibility.standard}"
      
      performance:
        failing_metric: "${context.performance_issue}"
        target_value: "${system_policies.performance.slo_defaults[context.metric_type]}"
        measurement_method: "${system_policies.performance.tools[context.metric_type]}"
        suggested_solutions: "${analyze.performance_solutions(context.bottleneck)}"
      
      new_feature:
        functionality: "${context.feature_description}"
        user_goals: "${context.user_stories}"
        acceptance_criteria: "${generate.acceptance_criteria(context.requirements)}"
        technical_components: "${analyze.required_components(context.feature)}"
        architecture_pattern: "${system_policies.architecture.default_patterns}"
      
      major_feature:
        requirements_update: "${analyze.requirement_changes(context.feature)}"
        design_impact: "${analyze.design_impact(context.feature)}"
        integration_points: "${analyze.integration_needs(context.feature)}"
        migration_strategy: "${generate.migration_plan(context.changes)}"
      
      spec_change:
        change_type: "${classify.spec_change(context.change_description)}"
        impacted_documents: "${analyze.document_cascade(context.changed_specs)}"
        backward_compatibility: "${analyze.compatibility(context.changes)}"
        migration_required: "${determine.migration_needs(context.changes)}"
      
      refactor:
        technical_debt: "${context.debt_description}"
        improvement_goals: "${context.refactor_goals}"
        risk_assessment: "${analyze.refactor_risk(context.scope)}"
        performance_gains: "${estimate.performance_improvement(context.changes)}"
      
      infra_perf:
        infrastructure_changes: "${context.infra_updates}"
        performance_targets: "${system_policies.performance.slo_defaults}"
        monitoring_setup: "${system_policies.infrastructure.monitoring}"
        capacity_planning: "${analyze.capacity_needs(context.expected_load)}"

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