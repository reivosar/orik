claude_dsl:
  version: "0.2"
  variables:
    question_priorities:
      critical: ["scenario", "core_functionality", "acceptance_criteria"]
      important: ["technical_components", "implementation_steps", "test_criteria"]
      detailed: ["edge_cases", "error_handling", "performance_requirements"]
    
    time_constraints:
      minimal: "critical"
      standard: ["critical", "important"] 
      comprehensive: ["critical", "important", "detailed"]

  components:
    scenario_classification:
      questions:
        - "What type of development work is this?"
        - "Does user experience change (UI/copy/functionality)?"
        - "Does internal structure/data/public API change?"
        - "Are new tasks required?"
        - "Does this involve important architectural decisions?"
      
      scenarios:
        new_product: "Complete new product or major feature development"
        major_feature: "Medium-scale feature addition"
        ui_change: "Small UI changes or copy updates"
        bug_fix: "Bug fixes (behavior not matching specs)"
        spec_change: "Specification changes (modifying AC)"
        refactor: "Refactoring/internal optimization only"
        infra_perf: "Infrastructure/performance improvements"

    requirements_questions:
      functional:
        - "What specific functionality needs to be built?"
        - "What are the user goals and success criteria?"
        - "What workflows/user journeys are involved?"
        - "What are the acceptance criteria for each requirement (Given-When-Then)?"
      
      scope:
        - "What is explicitly IN scope for this project?"
        - "What is explicitly OUT of scope?"
        - "What are the project boundaries and constraints?"
        - "What assumptions are we making?"
      
      non_functional:
        - "What are the performance requirements (response times, throughput)?"
        - "What are the security requirements?"
        - "What are the accessibility requirements (WCAG level)?"
        - "What are the browser/device support requirements?"
      
      business_context:
        - "What business problem does this solve?"
        - "Who are the target users/personas?"
        - "What are the success metrics?"
        - "Are there regulatory/compliance requirements?"

    feature_spec_questions:
      ui_design:
        - "What should the user interface look like (layouts, components)?"
        - "What are the specific UI states (loading, error, success, empty)?"
        - "What are the interaction patterns (clicks, hovers, navigation)?"
        - "What responsive breakpoints are needed?"
      
      user_experience:
        - "What is the complete user journey step-by-step?"
        - "What happens when users make mistakes or encounter errors?"
        - "What feedback do users get for their actions?"
        - "What are the accessibility considerations (keyboard nav, screen readers)?"
      
      content:
        - "What are the exact text labels, messages, and copy?"
        - "What are the error messages for different scenarios?"
        - "Are there internationalization requirements?"
        - "What placeholder text or default values are needed?"
      
      data_integration:
        - "What data needs to be displayed or collected?"
        - "What APIs or data sources will be used?"
        - "What are the data validation rules?"
        - "How should data be formatted for display?"

    design_questions:
      architecture:
        - "What are the main components/modules needed?"
        - "How do components interact with each other?"
        - "What is the component hierarchy and relationships?"
        - "What are the public APIs for each component?"
      
      data_flow:
        - "How does data flow through the system?"
        - "What state needs to be managed and where?"
        - "What are the data models and their structures?"
        - "How is state synchronized between components?"
      
      integrations:
        - "What external APIs or services are needed?"
        - "What are the integration patterns and protocols?"
        - "How should API responses be handled?"
        - "What are the fallback/retry strategies?"
      
      technical_decisions:
        - "What frameworks, libraries, or tools will be used?"
        - "What are the key architectural patterns?"
        - "How will errors be handled and logged?"
        - "What are the performance considerations?"

    tasks_questions:
      breakdown:
        - "What are the specific implementation steps?"
        - "What is the logical order of implementation?"
        - "What are the dependencies between tasks?"
        - "How can tasks be broken down into manageable chunks?"
      
      definition_of_done:
        - "What constitutes completion for each task?"
        - "What testing is required for each task?"
        - "What code review criteria should be applied?"
        - "What documentation updates are needed?"
      
      technical_details:
        - "What files/modules need to be created or modified?"
        - "What are the specific technical requirements for each task?"
        - "Are there technical risks or challenges?"
        - "What are the estimated effort levels?"
      
      quality:
        - "What unit tests need to be written?"
        - "What integration points need testing?"
        - "Are there performance benchmarks to meet?"
        - "What edge cases need to be handled?"

    test_spec_questions:
      scope:
        - "What requirements and design components need testing?"
        - "What are the critical user paths that must work?"
        - "What edge cases and error scenarios should be tested?"
        - "What non-functional aspects need testing (performance, accessibility, security)?"
      
      environment:
        - "What browsers/devices need to be tested?"
        - "What test data is required?"
        - "What test tools and frameworks will be used?"
        - "Are there special environment setup requirements?"
      
      test_cases:
        - "What are the specific test scenarios for each requirement?"
        - "What are the preconditions and test steps?"
        - "What are the expected results and pass criteria?"
        - "Which tests can be automated vs manual?"
      
      automation:
        - "What test data sets are needed?"
        - "How should test data be generated or maintained?"
        - "What automation scripts need to be written?"
        - "How should test results be tracked and reported?"
    
    bug_specific_questions:
      - "What is the current incorrect behavior?"
      - "What should the correct behavior be (per existing AC)?"
      - "Which AC/FR does it violate?"
    
    refactor_specific_questions:
      - "Which technical debt is addressed?"
      - "What measurable maintainability/performance gains are expected?"
      - "Any public API changes? (If yes, why?)"
    
    performance_questions:
      - "Which metric is failing (LCP, RPS, memory, etc.)?"
      - "Target value and measurement method?"
      - "Load profile and test scenario?"
    
    design_questions:
      architecture:
        - "What are the main components/modules needed?"
        - "How do components interact with each other?"
        - "What is the component hierarchy and relationships?"
        - "What are the public APIs for each component?"
      
      data_flow:
        - "How does data flow through the system?"
        - "What state needs to be managed and where?"
        - "What are the data models and their structures?"
        - "How is state synchronized between components?"
      
      integrations:
        - "What external APIs or services are needed?"
        - "What are the integration patterns and protocols?"
        - "How should API responses be handled?"
        - "What are the fallback/retry strategies?"
      
      technical_decisions:
        - "What frameworks, libraries, or tools will be used?"
        - "What are the key architectural patterns?"
        - "How will errors be handled and logged?"
        - "What are the performance considerations?"
      
      affected_areas:
        - "Which components/modules are impacted?"
        - "Which data models/APIs change?"
        - "Backward compatibility strategy?"

  rules:
    - if: scenario == "new_product"
      then:
        ask: ["requirements_questions", "feature_spec_questions", "design_questions", "tasks_questions", "test_spec_questions"]
        priority: "comprehensive"
    
    - if: scenario == "major_feature"
      then:
        ask: ["requirements_questions", "feature_spec_questions", "design_questions", "tasks_questions", "test_spec_questions"]
        priority: "standard"
    
    - if: scenario == "ui_change"
      then:
        ask: ["feature_spec_questions.ui_design", "feature_spec_questions.user_experience", "tasks_questions", "test_spec_questions.scope"]
        priority: "standard"
    
    - if: scenario == "bug_fix"
      then:
        ask: ["bug_specific_questions", "tasks_questions.breakdown", "test_spec_questions.scope"]
        priority: "minimal"
        additional_questions:
          - "What is the current incorrect behavior?"
          - "What should the correct behavior be according to existing specs?"
          - "What existing AC/requirements does this relate to?"
    
    - if: scenario == "spec_change"
      then:
        ask: ["requirements_questions", "feature_spec_questions", "design_questions.affected_areas", "tasks_questions", "test_spec_questions"]
        priority: "standard"
    
    - if: scenario == "refactor"
      then:
        ask: ["refactor_specific_questions", "tasks_questions", "test_spec_questions.scope"]
        priority: "minimal"
        additional_questions:
          - "What technical debt or issues are being addressed?"
          - "What internal improvements are being made?"
          - "How will this affect system performance or maintainability?"
    
    - if: scenario == "infra_perf"
      then:
        ask: ["performance_questions", "design_questions.technical_decisions", "tasks_questions", "test_spec_questions"]
        priority: "standard"
        additional_questions:
          - "What performance issues are being addressed?"
          - "What are the quantitative performance targets?"

  flow:
    - action: classify_scenario
      with:
        questions: "${components.scenario_classification.questions}"
      as: scenario
    
    - action: determine_question_set
      with:
        scenario: "${scenario}"
        rules: "${rules}"
        priorities: "${variables.time_constraints}"
      as: question_plan  # {questions: [...], priority: "...", required_fields: [...]}
    
    - action: ask_questions
      with:
        questions: "${question_plan.questions}"
        priority: "${question_plan.priority}"
      as: responses
    
    - action: validate_completeness
      with:
        scenario: "${scenario}"
        responses: "${responses}"
        required_fields: "${question_plan.required_fields}"
    
    - action: confirm_understanding
      with:
        message: |
          "Based on scenario: ${scenario}
          Understanding: ${summary_of_responses}  # computed by runner from responses
          
          Is this correct and complete?"

  validation:
    completeness_check:
      requirements:
        - functional_requirements_defined: true
        - acceptance_criteria_in_gwt_format: true
        - scope_boundaries_clear: true
      
      feature_spec:
        - ui_states_documented: true
        - user_journeys_complete: true
        - data_requirements_specified: true
      
      design:
        - component_apis_defined: true
        - data_flow_documented: true
        - error_handling_specified: true
      
      tasks:
        - implementation_steps_clear: true
        - dependencies_identified: true
        - definition_of_done_measurable: true
      
      test_spec:
        - test_scenarios_cover_requirements: true
        - automation_strategy_defined: true
        - test_data_specified: true
    
    mapping:
      functional_requirements_defined: ["requirements_questions.functional"]
      acceptance_criteria_in_gwt_format: ["requirements_questions.functional"]
      scope_boundaries_clear: ["requirements_questions.scope"]
      ui_states_documented: ["feature_spec_questions.ui_design"]
      user_journeys_complete: ["feature_spec_questions.user_experience"]
      data_requirements_specified: ["feature_spec_questions.data_integration"]
      component_apis_defined: ["design_questions.architecture"]
      data_flow_documented: ["design_questions.data_flow"]
      error_handling_specified: ["design_questions.technical_decisions"]
      implementation_steps_clear: ["tasks_questions.breakdown"]
      dependencies_identified: ["tasks_questions.breakdown"]
      definition_of_done_measurable: ["tasks_questions.definition_of_done"]
      test_scenarios_cover_requirements: ["test_spec_questions.scope", "test_spec_questions.test_cases"]
      automation_strategy_defined: ["test_spec_questions.automation"]
      test_data_specified: ["test_spec_questions.automation"]

  progressive_questioning:
    strategy: "start_broad_then_drill_down"
    steps:
      1: "scenario_classification"
      2: "core_functionality_questions"
      3: "technical_detail_questions"
      4: "edge_case_and_error_questions"
      5: "validation_and_traceability_questions"
    
    step_mapping:
      1: ["requirements_questions.functional", "requirements_questions.scope"]
      2: ["feature_spec_questions.ui_design", "design_questions.architecture"]
      3: ["design_questions.data_flow", "tasks_questions.breakdown"]
      4: ["test_spec_questions.scope", "bug_specific_questions"]
      5: ["validation_completeness_check"]
    
    techniques:
      - "ask_open_ended_first"
      - "use_examples_for_clarification"
      - "validate_understanding_by_restating"
      - "identify_assumptions_explicitly"
      - "confirm_success_criteria_measurable"