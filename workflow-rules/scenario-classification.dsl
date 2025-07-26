variables:
  development_scenarios:
    new_product: Complete new product or major feature development
    major_feature: Medium-scale feature addition
    ui_change: Small UI changes or copy updates
    bug_fix: Bug fixes (behavior not matching specs)
    spec_change: Specification changes (modifying AC)
    refactor: Refactoring/internal optimization only
    infra_perf: Infrastructure/performance improvements

components:
  classification_questions:
    user_impact: Does this change affect end user experience?
    system_architecture: Does this involve architectural changes?
    new_functionality: Are new features being added?
    existing_modification: Are existing features being modified?
    documentation_scope: What documentation already exists?
    urgency_level: What is the urgency/priority level?
    complexity_assessment: How complex is this change?
  
  scenario_indicators:
    new_product:
      keywords: [new application, major system, complete rebuild, greenfield]
      complexity: high
      documentation_scope: complete
      time_savings: baseline
      
    major_feature:
      keywords: [significant functionality, new workflow, API changes, integration]
      complexity: high
      documentation_scope: comprehensive
      time_savings: 30%
      
    ui_change:
      keywords: [interface updates, styling, copy changes, visual modifications]
      complexity: medium
      documentation_scope: focused
      time_savings: 60%
      
    bug_fix:
      keywords: [error correction, behavior mismatch, defect resolution]
      complexity: low
      documentation_scope: minimal
      time_savings: 75%
      
    spec_change:
      keywords: [requirement modification, acceptance criteria updates, business rules]
      complexity: medium
      documentation_scope: cascading
      time_savings: 40%
      
    refactor:
      keywords: [code improvement, optimization, restructuring, technical debt]
      complexity: medium
      documentation_scope: technical
      time_savings: 70%
      
    infra_perf:
      keywords: [performance optimization, infrastructure changes, scalability]
      complexity: medium
      documentation_scope: technical
      time_savings: 50%

routing_logic:
  classification_process:
    - present_classification_questions
    - analyze_user_responses
    - match_against_scenario_indicators
    - determine_primary_scenario
    - validate_classification_with_user
    - route_to_appropriate_workflow
  
  multi_scenario_handling:
    - detect_overlapping_scenarios
    - prioritize_dominant_scenario
    - note_secondary_considerations
    - adjust_documentation_requirements
  
  ambiguity_resolution:
    - ask_clarifying_questions
    - provide_scenario_examples
    - explain_documentation_implications
    - get_user_confirmation

validation_rules:
  classification_accuracy:
    - scenario_matches_indicators
    - documentation_scope_appropriate
    - time_estimation_realistic
    - user_confirms_understanding
  
  edge_case_handling:
    - hybrid_scenarios_documented
    - special_requirements_captured
    - exceptions_explicitly_noted
    - fallback_scenarios_defined