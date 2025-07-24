claude_dsl:
  version: "0.6"
  description: "Document creation policies and procedures for orik framework"
  
  variables:
    directory_structure:
      docs_root: "docs/"
      subdirectories:
        templates: "_templates/"
        dsl: "_dsl/"
        policy: "policy/"
        requirements: "requirements/"
        feature_specs: "fs/"
        design: "design/"
        tasks: "tasks/"
        test_specs: "tests/spec/"
        trace: "trace/"
        adr: "adr/"
        generated: "generated/"
        
    file_creation_rules:
      use_templates: true
      template_source: "docs/_templates/"
      version_directories: true
      latest_symlinks: true
      id_prefix_required: true
      
    naming_conventions:
      requirements_file: "requirements.md"
      feature_spec_pattern: "FS-{id:03d}-{slug}.md"
      design_file: "design.md"
      tasks_file: "tasks.md" 
      test_spec_file: "test-spec.md"
      trace_file: "trace.md"
      adr_pattern: "ADR-{id:03d}-{title}.md"
      
    version_management:
      strategy: "directory_based"  # v0.1/, v0.2/, v0.3/
      auto_increment: true
      preserve_history: true
      latest_alias: "latest.md"

  components:
    creation_workflow:
      new_product:
        steps:
          1: "create_version_directory"
          2: "apply_requirements_template"
          3: "create_feature_specs"
          4: "apply_design_template"
          5: "apply_tasks_template"
          6: "apply_test_spec_template"
          7: "update_latest_symlinks"
          8: "regenerate_trace_matrix"
        directories: ["docs/requirements/v{version}", "docs/design/v{version}", "docs/tasks/v{version}", "docs/tests/spec/v{version}"]
        files: ["requirements.md", "design.md", "tasks.md", "test-spec.md"]
        
      major_feature:
        steps:
          1: "determine_affected_documents"
          2: "create_or_update_requirements"
          3: "create_feature_specs"
          4: "update_design_components"
          5: "create_implementation_tasks"
          6: "update_test_specifications"
          7: "update_latest_symlinks"
          8: "regenerate_trace_matrix"
        directories: ["docs/requirements/v{version}", "docs/design/v{version}", "docs/tasks/v{version}", "docs/tests/spec/v{version}"]
        
      ui_change:
        steps:
          1: "identify_affected_feature_specs"
          2: "update_feature_specs"
          3: "create_ui_tasks"
          4: "update_test_specifications"
          5: "update_latest_symlinks"
          6: "regenerate_trace_matrix"
        directories: ["docs/tasks/v{version}", "docs/tests/spec/v{version}"]
        files: ["tasks.md", "test-spec.md"]
        
      bug_fix:
        steps:
          1: "reference_existing_requirements"
          2: "create_fix_tasks"
          3: "create_regression_tests"
          4: "update_latest_symlinks"
          5: "regenerate_trace_matrix"
        directories: ["docs/tasks/v{version}", "docs/tests/spec/v{version}"]
        files: ["tasks.md", "test-spec.md"]
        
      spec_change:
        steps:
          1: "identify_cascade_impact"
          2: "update_requirements"
          3: "update_affected_feature_specs"
          4: "update_affected_design"
          5: "update_implementation_tasks"
          6: "update_test_specifications"
          7: "update_latest_symlinks"
          8: "regenerate_trace_matrix"
        directories: ["docs/requirements/v{version}", "docs/design/v{version}", "docs/tasks/v{version}", "docs/tests/spec/v{version}"]
        
      refactor:
        steps:
          1: "document_technical_debt"
          2: "create_refactor_tasks"
          3: "add_regression_tests"
          4: "optional_design_notes"
          5: "update_latest_symlinks"
          6: "regenerate_trace_matrix"
        directories: ["docs/tasks/v{version}", "docs/tests/spec/v{version}"]
        files: ["tasks.md", "test-spec.md"]
        
      infra_perf:
        steps:
          1: "create_nfr_requirements"
          2: "update_performance_design"
          3: "create_infrastructure_tasks"
          4: "create_performance_tests"
          5: "update_latest_symlinks"
          6: "regenerate_trace_matrix"
        directories: ["docs/requirements/v{version}", "docs/design/v{version}", "docs/tasks/v{version}", "docs/tests/spec/v{version}"]

    template_application:
      requirements:
        source: "docs/_templates/requirements-template.md"
        target_pattern: "docs/requirements/v{version}/requirements.md"
        variables: ["NAME", "DATE", "VERSION", "ASSIGNEE"]
        id_generation: "FR-{id:03d}"
        
      feature_specs:
        source: "docs/_templates/feature-spec-template.md"
        target_pattern: "docs/fs/FS-{id:03d}-{slug}.md"
        variables: ["NAME", "DATE", "VERSION", "LINKED_REQUIREMENTS"]
        id_generation: "FS-{id:03d}"
        
      design:
        source: "docs/_templates/design-template.md"
        target_pattern: "docs/design/v{version}/design.md"
        variables: ["NAME", "DATE", "VERSION", "LINKED_FS"]
        id_generation: "D-{id:03d}"
        
      tasks:
        source: "docs/_templates/tasks-template.md"
        target_pattern: "docs/tasks/v{version}/tasks.md"
        variables: ["NAME", "DATE", "VERSION", "LINKED_DESIGN"]
        id_generation: "T-{id:03d}"
        
      test_specs:
        source: "docs/_templates/test-spec-template.md"
        target_pattern: "docs/tests/spec/v{version}/test-spec.md"
        variables: ["NAME", "DATE", "VERSION", "LINKED_REQUIREMENTS", "LINKED_FS", "LINKED_DESIGN"]
        id_generation: "TC-{id:03d}"

    symlink_management:
      latest_requirements: 
        target: "docs/requirements/latest.md"
        source: "v{latest_version}/requirements.md"
        
      latest_design:
        target: "docs/design/latest.md"
        source: "v{latest_version}/design.md"
        
      latest_tasks:
        target: "docs/tasks/latest.md"
        source: "v{latest_version}/tasks.md"
        
      latest_test_spec:
        target: "docs/tests/spec/latest.md"
        source: "v{latest_version}/test-spec.md"

    trace_generation:
      source_documents:
        - "docs/requirements/v*/requirements.md"
        - "docs/fs/FS-*.md"
        - "docs/design/v*/design.md"
        - "docs/tasks/v*/tasks.md"
        - "docs/tests/spec/v*/test-spec.md"
        
      output_files:
        human_readable: "docs/trace/trace.md"
        machine_readable: "docs/generated/trace.json"
        coverage_report: "docs/trace/coverage-report.md"
        
      id_extraction_patterns:
        fr_pattern: "FR-\\d{3}"
        fs_pattern: "FS-\\d{3}"
        d_pattern: "D-\\d{3}"
        t_pattern: "T-\\d{3}"
        tc_pattern: "TC-\\d{3}"
        nfr_pattern: "NFR-\\d{3}"
        nftc_pattern: "NFTC-\\d{3}"

  rules:
    file_creation:
      - name: "template_required"
        description: "All documents must use templates from docs/_templates/"
        enforcement: "mandatory"
        
      - name: "version_directory"
        description: "Versioned documents go in v{version}/ subdirectories"
        conditions: ["new_product", "major_feature", "spec_change"]
        enforcement: "mandatory"
        
      - name: "latest_symlink"
        description: "Update latest.md symlink after document creation"
        enforcement: "mandatory"
        
      - name: "id_uniqueness" 
        description: "All document IDs must be unique within type"
        enforcement: "mandatory"
        validation: "check_duplicate_ids"
        
      - name: "traceability_update"
        description: "Regenerate trace matrix after any document changes"
        enforcement: "mandatory"
        
    directory_structure:
      - name: "readonly_generated"
        description: "docs/generated/ is read-only, no manual edits"
        enforcement: "mandatory"
        ci_check: true
        
      - name: "preserve_templates"
        description: "docs/_templates/ should not be modified during document creation"
        enforcement: "mandatory"
        
      - name: "consistent_versioning"
        description: "Version directories must follow v{major}.{minor} pattern"
        enforcement: "mandatory"
        pattern: "v\\d+\\.\\d+"

    quality_assurance:
      - name: "template_variable_substitution"
        description: "All template variables must be replaced"
        validation: "check_template_variables"
        
      - name: "id_format_compliance"
        description: "All IDs must follow {TYPE}-{number:03d} format"
        validation: "validate_id_format"
        
      - name: "cross_reference_validity"
        description: "All document cross-references must exist"
        validation: "validate_cross_references"

  validation:
    pre_creation:
      - action: "verify_template_exists"
        required: true
      - action: "check_directory_permissions"
        required: true
      - action: "validate_version_increment"
        required: true
        
    post_creation:
      - action: "validate_document_format"
        required: true
      - action: "check_id_uniqueness"
        required: true
      - action: "verify_cross_references"
        required: true
      - action: "update_symlinks"
        required: true
      - action: "regenerate_trace"
        required: true

  automation:
    scripts:
      create_document: "scripts/create-document.py"
      update_symlinks: "scripts/update-symlinks.sh"
      regenerate_trace: "scripts/regenerate-trace.py"
      validate_structure: "scripts/validate-docs.py"
      
    make_targets:
      new_feature: "Create complete document set for new feature"
      update_docs: "Update existing documents with version increment"
      fix_bug: "Create minimal documentation for bug fix"
      validate: "Validate all documents and structure"
      trace: "Regenerate traceability matrix"
      clean: "Remove generated files and rebuild"