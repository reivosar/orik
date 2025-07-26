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
    nfr: "NFR-{id}-{slug}.md"

components:
  document_types:
    fr: Functional Requirements
    fs: Feature Specifications
    nfr: Non-Functional Requirements
    design: Technical Design
    tasks: Implementation Tasks
    test_specs: Test Specifications
    trace: Traceability Matrix
    adr: Architecture Decision Records
  
  creation_rules:
    template_mandatory: All documents must use approved templates
    section_completeness: All template sections must be filled
    id_consistency: Document IDs must follow naming conventions
    cross_reference_validation: All references must resolve correctly
  
  scenario_requirements:
    new_product:
      required: [fr, fs, design, tasks, test_specs, trace, adr]
      optional: [nfr]
    major_feature:
      required: [fs, design, tasks, test_specs]
      update: [fr, trace]
      optional: [adr]
    ui_change:
      required: [fs, tasks, test_specs]
      update: [fr, trace]
      skip: [design, nfr, adr]
    bug_fix:
      required: [tasks, test_specs]
      reference: [fr]
      update: [trace]
      skip: [fs, design, nfr, adr]
    spec_change:
      required: [fr, fs, tasks, test_specs]
      update: [design, trace]
      optional: [adr]
    refactor:
      required: [tasks]
      update: [design, trace]
      optional: [test_specs, adr]
      skip: [fr, fs, nfr]
    infra_perf:
      required: [nfr, design, tasks, test_specs]
      update: [trace]
      optional: [adr]
      skip: [fr, fs]

quality_enforcement:
  pre_creation_checks:
    - template_exists
    - directory_structure_valid
    - permissions_adequate
    - naming_convention_valid
  
  post_creation_validation:
    - all_sections_completed
    - cross_references_valid
    - id_consistency_maintained
    - traceability_updated
  
  continuous_validation:
    - orphaned_references_detection
    - document_synchronization
    - version_consistency
    - template_compliance

automation_rules:
  trace_regeneration:
    trigger: any_document_change
    action: regenerate_trace_matrix
    validation: ensure_no_orphans
  
  symlink_management:
    trigger: new_version_creation
    action: update_latest_symlinks
    validation: links_point_correctly
  
  template_updates:
    trigger: template_modification
    action: validate_existing_documents
    remediation: flag_non_compliant_docs