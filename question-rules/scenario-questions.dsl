variables:
  question_modes:
    critical: 3-5_essential_questions
    standard: 8-15_comprehensive_questions
    detailed: 20-30_exhaustive_questions

components:
  new_product_questions:
    essential: [
      What is the core problem this product solves?,
      Who are the primary users and what are their goals?,
      What are the key success metrics?
    ]
    comprehensive: [
      What functionality must be included in MVP?,
      What are the technical constraints and requirements?,
      How will users discover and onboard to this product?,
      What are the security and compliance requirements?,
      What integrations are required?,
      What are the performance expectations?,
      How will this be maintained and supported?
    ]
    exhaustive: [
      What user research has been conducted?,
      What are the competitive alternatives?,
      What is the business model and revenue impact?,
      What are the internationalization requirements?,
      What accessibility standards must be met?,
      What are the disaster recovery requirements?,
      What monitoring and analytics are needed?,
      What are the scaling projections?,
      What documentation standards apply?,
      What approval processes are required?
    ]
  
  major_feature_questions:
    essential: [
      What new functionality is being added?,
      How does this integrate with existing features?,
      What user workflows are affected?
    ]
    comprehensive: [
      What are the acceptance criteria?,
      How will this feature be discovered by users?,
      What data needs to be captured or displayed?,
      What are the error scenarios?,
      How does this affect performance?,
      What testing is required?,
      What documentation needs updating?
    ]
    exhaustive: [
      What user feedback informed this feature?,
      What A/B testing is planned?,
      How will feature adoption be measured?,
      What rollback plan exists?,
      What training materials are needed?,
      What customer support impact is expected?,
      What legal or compliance considerations apply?
    ]
  
  ui_change_questions:
    essential: [
      What UI elements are changing?,
      What is the expected user behavior?,
      Which devices/browsers need support?
    ]
    comprehensive: [
      What are the different UI states?,
      How do users interact with each element?,
      What accessibility requirements apply?,
      What responsive behavior is needed?,
      What error states need handling?
    ]
  
  bug_fix_questions:
    essential: [
      What is the current incorrect behavior?,
      What should the correct behavior be?,
      How can this be tested?
    ]
  
  spec_change_questions:
    essential: [
      What requirements are changing?,
      Why is this change necessary?,
      What downstream impacts exist?
    ]
    comprehensive: [
      What stakeholders need to approve this change?,
      What existing functionality is affected?,
      What testing needs to be updated?,
      What documentation requires revision?,
      What communication plan is needed?,
      What timeline constraints exist?
    ]
  
  refactor_questions:
    essential: [
      What technical debt is being addressed?,
      What benefits will this provide?,
      What risks are involved?
    ]
    comprehensive: [
      What performance improvements are expected?,
      What maintenance burden will be reduced?,
      What new capabilities will this enable?,
      How will regression be prevented?
    ]
  
  infra_perf_questions:
    essential: [
      What performance issues are being addressed?,
      What are the target performance metrics?,
      How will improvements be measured?
    ]
    comprehensive: [
      What infrastructure changes are required?,
      What monitoring will be implemented?,
      What capacity planning is needed?,
      What disaster recovery considerations apply?,
      What security implications exist?,
      What cost impacts are expected?
    ]

progressive_questioning:
  flow_control:
    start_broad: Ask high-level questions first
    drill_down: Follow up based on responses
    validate_understanding: Confirm interpretation
    identify_gaps: Find missing information
    prioritize_remaining: Focus on critical unknowns
  
  question_selection:
    user_expertise_level: Adjust complexity based on user knowledge
    time_constraints: Use appropriate mode (critical/standard/detailed)
    scenario_complexity: Match question depth to scenario scope
    previous_answers: Skip redundant questions
  
  adaptive_behavior:
    unclear_responses: Ask clarifying follow-ups
    conflicting_information: Resolve contradictions
    scope_expansion: Add questions if scope grows
    early_termination: Allow shortened flows for simple cases