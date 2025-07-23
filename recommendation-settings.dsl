claude_dsl:
  version: "0.1"
  description: "Recommendation settings for system policies and scenario-specific defaults"
  
  variables:
    input_vars: ["scenario", "context"]
    
    recommendation_source:
      system_policy: "Use organization-wide design policies and standards"
      project_specific: "Define per-project recommendations"
      hybrid: "System policy as base, project overrides allowed"
    
    output_schema:
      rec_scope:
        can_analyze: []      # Array of strings
        best_practices: []   # Array of strings  
        needs_confirmation: [] # Array of strings
      
      recommendations:
        formatted: ""        # Human-readable text
        raw:
          sections: []       # Machine-readable array
          metadata: {}       # Processing info
  
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
        # Best practices - always recommend these
        best_practices:
          testing_approach: "Write regression test before fixing"
          verification_steps:
            - "Reproduce in test environment"
            - "Verify fix doesn't break other features"
            - "Test in staging before production"
          documentation: "Update relevant documentation and changelog"
        
        # Context-based - can analyze and suggest based on codebase/docs
        context_based:
          correct_behavior: "${lookup.acceptance_criteria(context.affected_ac_id)}"
          impact_analysis: "${analyze.codebase_dependencies(context.affected_component)}"
          affected_features: "${search.related_functionality(context.bug_location)}"
          suggested_fix_approach: "${suggest.fix_strategy(context.bug_type)}"
          related_tests: "${find.existing_tests(context.component)}"
        
        # Must ask user - cannot be guessed or inferred
        required_from_user:
          - current_behavior: "What is the actual bug behavior?"
          - affected_feature: "Which feature/component is broken?"
          - affected_ac_id: "Which acceptance criteria ID?"
          - reproduction_steps: "How to reproduce the bug?"
      
      ui_change:
        best_practices:
          ui_states: ["Loading", "Error", "Success", "Empty", "Disabled"]
          responsive_breakpoints: ["Mobile (<768px)", "Tablet (768-1024px)", "Desktop (>1024px)"]
          accessibility: "WCAG 2.1 AA compliance required"
          testing: "Visual regression testing recommended"
        
        context_based:
          interaction_flow: "${analyze.user_flow(context.feature)}"
          affected_pages: "${analyze.page_impact(context.components)}"
          style_consistency: "${check.design_system_compliance(context.changes)}"
        
        required_from_user:
          - affected_components: "Which UI components are changing?"
          - change_description: "What specific UI changes?"
          - user_impact: "How does this affect user workflow?"
      
      performance:
        best_practices:
          measurement_tools: ["k6 for load testing", "Lighthouse for web vitals", "APM for monitoring"]
          optimization_patterns: ["Caching", "Database indexing", "CDN", "Code splitting"]
          slo_defaults:
            api_p95: "< 200ms"
            web_lcp: "< 2.5s"
            error_rate: "< 0.1%"
        
        context_based:
          target_value: "${lookup.slo_for_metric(context.metric_type)}"
          suggested_solutions: "${analyze.performance_solutions(context.bottleneck)}"
          infrastructure_needs: "${estimate.scaling_requirements(context.load)}"
        
        required_from_user:
          - performance_issue: "What performance metric is failing?"
          - current_value: "What is the current measured value?"
          - expected_load: "What is the expected traffic/load?"
      
      new_feature:
        best_practices:
          architecture_patterns: ["Clean Architecture", "Domain-Driven Design", "SOLID principles"]
          testing_strategy: "Test Pyramid - Unit > Integration > E2E"
          documentation: ["API documentation", "User guide", "Technical design doc"]
          security: "Security by design - threat modeling required"
        
        context_based:
          technical_components: "${analyze.required_components(context.feature)}"
          integration_points: "${analyze.system_integrations(context.feature)}"
          data_models: "${design.data_structures(context.requirements)}"
          acceptance_criteria: "${generate.acceptance_criteria(context.user_stories)}"
        
        required_from_user:
          - feature_description: "What is the new feature?"
          - user_stories: "What are the user goals?"
          - business_value: "What business problem does this solve?"
          - success_metrics: "How will we measure success?"
      
      major_feature:
        best_practices:
          phased_delivery: "Break into MVPs and iterative releases"
          risk_mitigation: ["Feature flags", "Canary deployments", "Rollback plans"]
          coordination: "Cross-team alignment and communication plan"
          documentation: "Comprehensive design docs and ADRs required"
        
        context_based:
          design_impact: "${analyze.design_impact(context.feature)}"
          migration_strategy: "${generate.migration_plan(context.changes)}"
          dependency_map: "${analyze.system_dependencies(context.affected_systems)}"
          timeline_estimate: "${estimate.development_timeline(context.scope)}"
        
        required_from_user:
          - feature_scope: "What is the scope of this feature?"
          - affected_systems: "Which existing systems are affected?"
          - integration_needs: "What integrations are required?"
          - constraints: "Any technical/business constraints?"
      
      spec_change:
        best_practices:
          change_management: "Document all changes with clear rationale"
          communication: "Notify all stakeholders before implementation"
          versioning: "Maintain backward compatibility when possible"
          validation: "Re-test all affected features"
        
        context_based:
          impacted_documents: "${analyze.document_cascade(context.changed_ac_ids)}"
          backward_compatibility: "${analyze.compatibility(context.changes)}"
          migration_path: "${design.migration_strategy(context.changes)}"
          risk_level: "${assess.change_risk(context.scope)}"
        
        required_from_user:
          - change_description: "What specifications are changing?"
          - changed_ac_ids: "Which AC IDs are affected?"
          - reason_for_change: "Why is this change needed?"
          - timeline: "When does this need to be implemented?"
      
      refactor:
        best_practices:
          principles: ["Boy Scout Rule", "SOLID", "DRY", "KISS"]
          safety_measures: ["Comprehensive tests before refactoring", "Small incremental changes"]
          metrics: "Track complexity, test coverage, performance before/after"
          review_process: "Mandatory code review with senior developers"
        
        context_based:
          improvement_areas: "${analyze.code_quality_issues(context.scope)}"
          risk_assessment: "${analyze.refactor_risk(context.scope)}"
          performance_impact: "${estimate.performance_improvement(context.changes)}"
          testing_gaps: "${identify.missing_tests(context.scope)}"
        
        required_from_user:
          - debt_description: "What technical debt is being addressed?"
          - refactor_scope: "What is the scope of refactoring?"
          - trigger: "Why refactor now?"
          - constraints: "Any constraints (time, resources, compatibility)?"
      
      infra_perf:
        best_practices:
          scaling_strategies: ["Horizontal scaling", "Auto-scaling", "Load balancing"]
          monitoring_stack: ["Prometheus", "Grafana", "ELK", "APM tools"]
          nfr_categories: ["Performance", "Scalability", "Reliability", "Availability"]
          cost_optimization: "Right-sizing, reserved instances, spot instances"
        
        context_based:
          capacity_planning: "${analyze.capacity_needs(context.expected_load)}"
          architecture_changes: "${suggest.architecture_improvements(context.bottlenecks)}"
          monitoring_gaps: "${identify.monitoring_needs(context.metrics)}"
          cost_estimate: "${estimate.infrastructure_cost(context.scale)}"
        
        required_from_user:
          - infrastructure_needs: "What infrastructure changes are needed?"
          - performance_goals: "What specific performance targets?"
          - current_bottlenecks: "What are the current bottlenecks?"
          - budget_constraints: "Any budget constraints?"
    
    # Ensure all scenarios have required sections (empty if not applicable)
    scenario_defaults:
      best_practices: []
      context_based: {}
      required_from_user: []

  rules:
    - name: "assess_capability"
      description: "Determine what can be recommended vs what needs user input"
      logic:
        - "If scenario has best_practices → can recommend those"
        - "If context allows context_based analysis → can recommend those"  
        - "If only required_from_user fields → cannot recommend, ask for guidance"
    
    - name: "determine_recommendation_source"
      description: "Ask user whether to use system policies or define custom (only when recommendations possible)"
      prompt: |
        "Would you like me to use:
        1. System-wide design policies (recommended for consistency)
        2. Project-specific recommendations
        3. System policies with project overrides
        
        Choice [1-3]:"
    
    - name: "handle_insufficient_context"
      description: "When recommendations impossible, offer alternatives"
      options:
        1: "Gather required information first"
        2: "Manual question-answer approach"
        3: "Skip to direct documentation creation"

  flow:
    - action: set_vars
      with:
        scenario: "${args.scenario}"
        context: "${args.context}"
    
    # First, ask for any information that requires human judgment or is unknown
    - action: identify_required_information
      with:
        scenario: "${scenario}"
        context: "${context}"
      as: missing_info
    
    - if: missing_info.has_requirements
      then:
        - action: ask_required_questions
          with:
            questions: "${missing_info.questions}"
            prompt: "I need some information that requires your input:"
          as: user_responses
    
    # Then analyze what can be recommended vs needs confirmation
    - action: analyze_recommendation_scope
      with:
        scenario: "${scenario}"
        context: "${context + user_responses}"
      as: rec_scope   # {can_analyze:[], best_practices:[], needs_confirmation:[]}
    
    # Present comprehensive recommendation offer
    - action: present_recommendation_offer
      with:
        prompt: |
          "Based on your ${scenario} scenario, I can provide these recommendations:
          
          ✅ I can analyze and suggest:
          ${rec_scope.can_analyze}
          
          ✅ I can recommend best practices for:
          ${rec_scope.best_practices}
          
          ⚠️  These will need your confirmation:
          ${rec_scope.needs_confirmation}
          
          Would you like me to proceed with these recommendations? [y/n]"
      as: wants_recommendations
    
    - if: wants_recommendations == "y"
      then:
        - action: ask_recommendation_source
          with:
            prompt: "${rules.determine_recommendation_source.prompt}"
          as: source_preference
        
        - action: generate_comprehensive_recommendations
          with:
            scenario: "${scenario}"
            context: "${context + user_responses}"
            source: "${source_preference}"
          as: recommendations
        
        - action: present_recommendations_for_confirmation
          with:
            recommendations: "${recommendations}"
            prompt: |
              "Here are my recommendations:
              
              ${recommendations.formatted}
              
              Please review each section:
              1. Accept all recommendations as-is
              2. Modify specific recommendations  
              3. Proceed with manual approach instead
              
              Your choice [1-3]:"
          as: approval_response
        
        - if: approval_response == "1"
          then:
            - action: proceed_with_recommendations
              with:
                approved_recommendations: "${recommendations}"
        
        - if: approval_response == "2"  
          then:
            - action: refine_recommendations_interactively
              with:
                base_recommendations: "${recommendations}"
        
        - if: approval_response == "3"
          then:
            - action: fallback_to_manual_questions
    
    - if: wants_recommendations != "y"
      then:
        - action: fallback_to_manual_questions

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