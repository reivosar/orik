# CI/CD Scripts Templates

This document provides Python and Node.js script templates for automated quality gate validation.

## 1. Traceability Validation Script

### validate-traceability.py
```python
#!/usr/bin/env python3
"""
Traceability Matrix Validation Script
Validates complete FR → FS → D → T → TC traceability chains
"""

import re
import sys
import json
import argparse
from pathlib import Path
from typing import Dict, List, Set, Tuple
from collections import defaultdict

class TraceabilityValidator:
    def __init__(self, trace_file: Path, docs_dir: Path):
        self.trace_file = trace_file
        self.docs_dir = docs_dir
        self.errors = []
        self.warnings = []
        
        # ID patterns
        self.id_patterns = {
            'FR': r'FR-\d{3}',
            'FS': r'FS-\d{3}',
            'D': r'D-\d{3}',
            'T': r'T-\d{3}(?:\.\d+)?',
            'TC': r'TC-\d{3}'
        }
    
    def find_documents(self) -> Dict[str, Set[str]]:
        """Find all document IDs in the repository"""
        doc_ids = defaultdict(set)
        
        for doc_type, pattern in self.id_patterns.items():
            search_dirs = {
                'FR': 'requirements',
                'FS': 'specs', 
                'D': 'design',
                'T': 'tasks',
                'TC': 'tests'
            }
            
            search_dir = self.docs_dir / search_dirs.get(doc_type, '')
            if search_dir.exists():
                for file_path in search_dir.rglob('*.md'):
                    content = file_path.read_text(encoding='utf-8')
                    matches = re.findall(pattern, content)
                    doc_ids[doc_type].update(matches)
        
        return doc_ids
    
    def parse_trace_matrix(self) -> List[Dict]:
        """Parse the traceability matrix"""
        if not self.trace_file.exists():
            self.errors.append(f"Trace file not found: {self.trace_file}")
            return []
        
        content = self.trace_file.read_text(encoding='utf-8')
        
        # Find trace matrix table
        table_pattern = r'\| (FR-\d{3}) \| .* \| (FS-\d{3}(?:, ?FS-\d{3})*) \| .* \| (D-\d{3}(?:, ?D-\d{3})*) \| .* \| (T-\d{3}(?:\.\d+)?(?:, ?T-\d{3}(?:\.\d+)?)*) \| .* \| (TC-\d{3}(?:, ?TC-\d{3})*) \|'
        
        traces = []
        for match in re.finditer(table_pattern, content):
            fr_id = match.group(1)
            fs_ids = [id.strip() for id in match.group(2).split(',')]
            d_ids = [id.strip() for id in match.group(3).split(',')]
            t_ids = [id.strip() for id in match.group(4).split(',')]
            tc_ids = [id.strip() for id in match.group(5).split(',')]
            
            traces.append({
                'fr': fr_id,
                'fs': fs_ids,
                'd': d_ids,
                't': t_ids,
                'tc': tc_ids
            })
        
        return traces
    
    def validate_coverage(self, doc_ids: Dict[str, Set[str]], traces: List[Dict]) -> None:
        """Validate 100% coverage requirements"""
        traced_frs = {trace['fr'] for trace in traces}
        all_frs = doc_ids['FR']
        
        # Check FR coverage
        missing_frs = all_frs - traced_frs
        if missing_frs:
            self.errors.append(f"FRs missing from trace matrix: {sorted(missing_frs)}")
        
        # Check for orphaned references
        for trace in traces:
            for fs_id in trace['fs']:
                if fs_id not in doc_ids['FS']:
                    self.errors.append(f"Orphaned FS reference: {fs_id} in trace for {trace['fr']}")
            
            for d_id in trace['d']:
                if d_id not in doc_ids['D']:
                    self.errors.append(f"Orphaned D reference: {d_id} in trace for {trace['fr']}")
            
            for t_id in trace['t']:
                if t_id not in doc_ids['T']:
                    self.errors.append(f"Orphaned T reference: {t_id} in trace for {trace['fr']}")
            
            for tc_id in trace['tc']:
                if tc_id not in doc_ids['TC']:
                    self.errors.append(f"Orphaned TC reference: {tc_id} in trace for {trace['fr']}")
    
    def validate_chains(self, traces: List[Dict]) -> None:
        """Validate complete traceability chains"""
        for trace in traces:
            fr_id = trace['fr']
            
            # Every FR must have at least one FS
            if not trace['fs'] or trace['fs'] == ['']:
                self.errors.append(f"FR {fr_id} has no FS coverage")
            
            # Every FS must have at least one D
            if not trace['d'] or trace['d'] == ['']:
                self.errors.append(f"FR {fr_id} has no D coverage")
            
            # Every D must have at least one T
            if not trace['t'] or trace['t'] == ['']:
                self.errors.append(f"FR {fr_id} has no T coverage")
            
            # Every T must have at least one TC
            if not trace['tc'] or trace['tc'] == ['']:
                self.errors.append(f"FR {fr_id} has no TC coverage")
    
    def generate_report(self) -> Dict:
        """Generate validation report"""
        doc_ids = self.find_documents()
        traces = self.parse_trace_matrix()
        
        self.validate_coverage(doc_ids, traces)
        self.validate_chains(traces)
        
        return {
            'status': 'PASS' if not self.errors else 'FAIL',
            'errors': self.errors,
            'warnings': self.warnings,
            'statistics': {
                'total_frs': len(doc_ids['FR']),
                'total_traces': len(traces),
                'coverage_percentage': len({t['fr'] for t in traces}) / len(doc_ids['FR']) * 100 if doc_ids['FR'] else 0
            }
        }

def main():
    parser = argparse.ArgumentParser(description='Validate traceability matrix')
    parser.add_argument('trace_file', help='Path to trace.md file')
    parser.add_argument('--docs-dir', default='docs', help='Documentation directory')
    parser.add_argument('--json', action='store_true', help='Output JSON report')
    
    args = parser.parse_args()
    
    validator = TraceabilityValidator(Path(args.trace_file), Path(args.docs_dir))
    report = validator.generate_report()
    
    if args.json:
        print(json.dumps(report, indent=2))
    else:
        print(f"Traceability Validation: {report['status']}")
        if report['errors']:
            print("❌ Errors:")
            for error in report['errors']:
                print(f"  - {error}")
        if report['warnings']:
            print("⚠️ Warnings:")
            for warning in report['warnings']:
                print(f"  - {warning}")
        
        stats = report['statistics']
        print(f"📊 Statistics:")
        print(f"  - Total FRs: {stats['total_frs']}")
        print(f"  - Total traces: {stats['total_traces']}")
        print(f"  - Coverage: {stats['coverage_percentage']:.1f}%")
    
    sys.exit(0 if report['status'] == 'PASS' else 1)

if __name__ == '__main__':
    main()
```

## 2. Test Tag Validation Script

### validate-test-tags.py
```python
#!/usr/bin/env python3
"""
Test Tag Validation Script
Ensures all tests have proper FR/AC tags for traceability
"""

import re
import sys
import json
import argparse
from pathlib import Path
from typing import Dict, List, Set

class TestTagValidator:
    def __init__(self, test_dir: Path):
        self.test_dir = test_dir
        self.errors = []
        self.warnings = []
        
        # Tag patterns
        self.tag_patterns = {
            'fr': r'@FR-\d{3}',
            'ac': r'@AC-\d{3}'
        }
    
    def find_test_files(self) -> List[Path]:
        """Find all test files"""
        patterns = ['**/*.test.ts', '**/*.test.js', '**/*.spec.ts', '**/*.spec.js']
        test_files = []
        
        for pattern in patterns:
            test_files.extend(self.test_dir.rglob(pattern))
        
        return list(set(test_files))
    
    def extract_tags_from_file(self, file_path: Path) -> Dict[str, Set[str]]:
        """Extract FR/AC tags from a test file"""
        content = file_path.read_text(encoding='utf-8')
        
        tags = {
            'fr': set(re.findall(self.tag_patterns['fr'], content)),
            'ac': set(re.findall(self.tag_patterns['ac'], content))
        }
        
        return tags
    
    def validate_file_tags(self, file_path: Path) -> Dict:
        """Validate tags in a single test file"""
        tags = self.extract_tags_from_file(file_path)
        file_errors = []
        file_warnings = []
        
        # Check if file has any tags
        if not tags['fr'] and not tags['ac']:
            file_errors.append(f"No FR/AC tags found in {file_path}")
        
        # Check for test cases without tags
        content = file_path.read_text(encoding='utf-8')
        
        # Find test cases (it/test blocks)
        test_cases = re.findall(r'(?:it|test)\s*\(\s*[\'"]([^\'"]+)[\'"]', content)
        
        if test_cases and not tags['fr'] and not tags['ac']:
            file_warnings.append(f"Test cases found but no FR/AC tags in {file_path}")
        
        return {
            'file': str(file_path),
            'tags': {k: list(v) for k, v in tags.items()},
            'test_cases': len(test_cases),
            'errors': file_errors,
            'warnings': file_warnings
        }
    
    def generate_report(self) -> Dict:
        """Generate validation report"""
        test_files = self.find_test_files()
        file_reports = []
        all_fr_tags = set()
        all_ac_tags = set()
        
        for file_path in test_files:
            report = self.validate_file_tags(file_path)
            file_reports.append(report)
            
            self.errors.extend(report['errors'])
            self.warnings.extend(report['warnings'])
            
            all_fr_tags.update(report['tags']['fr'])
            all_ac_tags.update(report['tags']['ac'])
        
        return {
            'status': 'PASS' if not self.errors else 'FAIL',
            'errors': self.errors,
            'warnings': self.warnings,
            'files': file_reports,
            'statistics': {
                'total_test_files': len(test_files),
                'files_with_tags': len([f for f in file_reports if f['tags']['fr'] or f['tags']['ac']]),
                'unique_fr_tags': len(all_fr_tags),
                'unique_ac_tags': len(all_ac_tags),
                'coverage_percentage': len([f for f in file_reports if f['tags']['fr'] or f['tags']['ac']]) / len(test_files) * 100 if test_files else 0
            }
        }

def main():
    parser = argparse.ArgumentParser(description='Validate test FR/AC tags')
    parser.add_argument('test_dir', help='Test directory path')
    parser.add_argument('--json', action='store_true', help='Output JSON report')
    
    args = parser.parse_args()
    
    validator = TestTagValidator(Path(args.test_dir))
    report = validator.generate_report()
    
    if args.json:
        print(json.dumps(report, indent=2))
    else:
        print(f"Test Tag Validation: {report['status']}")
        if report['errors']:
            print("❌ Errors:")
            for error in report['errors']:
                print(f"  - {error}")
        if report['warnings']:
            print("⚠️ Warnings:")
            for warning in report['warnings']:
                print(f"  - {warning}")
        
        stats = report['statistics']
        print(f"📊 Statistics:")
        print(f"  - Total test files: {stats['total_test_files']}")
        print(f"  - Files with tags: {stats['files_with_tags']}")
        print(f"  - Tag coverage: {stats['coverage_percentage']:.1f}%")
        print(f"  - Unique FR tags: {stats['unique_fr_tags']}")
        print(f"  - Unique AC tags: {stats['unique_ac_tags']}")
    
    sys.exit(0 if report['status'] == 'PASS' else 1)

if __name__ == '__main__':
    main()
```

## 3. Coverage Threshold Checker

### check-coverage-threshold.js
```javascript
#!/usr/bin/env node
/**
 * Coverage Threshold Checker
 * Validates test coverage meets minimum requirements
 */

const fs = require('fs');
const path = require('path');

class CoverageChecker {
    constructor(coverageFile, threshold) {
        this.coverageFile = coverageFile;
        this.threshold = threshold;
        this.errors = [];
        this.warnings = [];
    }

    loadCoverageData() {
        try {
            const data = fs.readFileSync(this.coverageFile, 'utf8');
            return JSON.parse(data);
        } catch (error) {
            this.errors.push(`Failed to load coverage file: ${error.message}`);
            return null;
        }
    }

    validateCoverage(coverageData) {
        const total = coverageData.total;
        const metrics = ['lines', 'functions', 'branches', 'statements'];
        
        const results = {};
        
        for (const metric of metrics) {
            const pct = total[metric].pct;
            results[metric] = {
                percentage: pct,
                passed: pct >= this.threshold
            };
            
            if (pct < this.threshold) {
                this.errors.push(`${metric} coverage ${pct}% below threshold ${this.threshold}%`);
            }
        }
        
        return results;
    }

    generateReport() {
        const coverageData = this.loadCoverageData();
        if (!coverageData) {
            return {
                status: 'FAIL',
                errors: this.errors,
                warnings: this.warnings
            };
        }

        const results = this.validateCoverage(coverageData);
        
        return {
            status: this.errors.length === 0 ? 'PASS' : 'FAIL',
            errors: this.errors,
            warnings: this.warnings,
            results: results,
            threshold: this.threshold
        };
    }
}

function main() {
    const args = process.argv.slice(2);
    
    if (args.length < 2) {
        console.error('Usage: check-coverage-threshold.js <coverage-file> <threshold>');
        process.exit(1);
    }
    
    const [coverageFile, threshold] = args;
    const checker = new CoverageChecker(coverageFile, parseInt(threshold));
    
    const report = checker.generateReport();
    
    console.log(`Coverage Validation: ${report.status}`);
    
    if (report.errors && report.errors.length > 0) {
        console.log('❌ Errors:');
        report.errors.forEach(error => console.log(`  - ${error}`));
    }
    
    if (report.results) {
        console.log('📊 Coverage Results:');
        Object.entries(report.results).forEach(([metric, result]) => {
            const status = result.passed ? '✅' : '❌';
            console.log(`  ${status} ${metric}: ${result.percentage}%`);
        });
    }
    
    process.exit(report.status === 'PASS' ? 0 : 1);
}

if (require.main === module) {
    main();
}

module.exports = CoverageChecker;
```

## 4. Bundle Size Checker

### check-bundle-size.js
```javascript
#!/usr/bin/env node
/**
 * Bundle Size Checker
 * Validates that bundle size doesn't exceed limits
 */

const fs = require('fs');
const path = require('path');

class BundleSizeChecker {
    constructor(distDir, maxSizeKB) {
        this.distDir = distDir;
        this.maxSizeKB = maxSizeKB;
        this.errors = [];
        this.warnings = [];
    }

    getDirectorySize(dirPath) {
        let totalSize = 0;
        
        const files = fs.readdirSync(dirPath);
        
        for (const file of files) {
            const filePath = path.join(dirPath, file);
            const stats = fs.statSync(filePath);
            
            if (stats.isDirectory()) {
                totalSize += this.getDirectorySize(filePath);
            } else {
                totalSize += stats.size;
            }
        }
        
        return totalSize;
    }

    analyzeBundle() {
        try {
            const totalBytes = this.getDirectorySize(this.distDir);
            const totalKB = Math.round(totalBytes / 1024);
            const totalMB = (totalKB / 1024).toFixed(2);
            
            const result = {
                totalBytes,
                totalKB,
                totalMB,
                maxSizeKB: this.maxSizeKB,
                passed: totalKB <= this.maxSizeKB
            };
            
            if (!result.passed) {
                this.errors.push(`Bundle size ${totalKB}KB exceeds limit ${this.maxSizeKB}KB`);
            } else if (totalKB > this.maxSizeKB * 0.9) {
                this.warnings.push(`Bundle size ${totalKB}KB is approaching limit ${this.maxSizeKB}KB`);
            }
            
            return result;
        } catch (error) {
            this.errors.push(`Failed to analyze bundle: ${error.message}`);
            return null;
        }
    }

    findLargestFiles() {
        const files = [];
        
        function collectFiles(dirPath) {
            const entries = fs.readdirSync(dirPath);
            
            for (const entry of entries) {
                const entryPath = path.join(dirPath, entry);
                const stats = fs.statSync(entryPath);
                
                if (stats.isDirectory()) {
                    collectFiles(entryPath);
                } else {
                    files.push({
                        path: entryPath,
                        size: stats.size,
                        sizeKB: Math.round(stats.size / 1024)
                    });
                }
            }
        }
        
        collectFiles(this.distDir);
        
        return files
            .sort((a, b) => b.size - a.size)
            .slice(0, 10);
    }

    generateReport() {
        const bundleAnalysis = this.analyzeBundle();
        if (!bundleAnalysis) {
            return {
                status: 'FAIL',
                errors: this.errors,
                warnings: this.warnings
            };
        }

        const largestFiles = this.findLargestFiles();
        
        return {
            status: this.errors.length === 0 ? 'PASS' : 'FAIL',
            errors: this.errors,
            warnings: this.warnings,
            bundle: bundleAnalysis,
            largestFiles: largestFiles
        };
    }
}

function main() {
    const args = process.argv.slice(2);
    
    if (args.length < 2) {
        console.error('Usage: check-bundle-size.js <dist-dir> <max-size-kb>');
        process.exit(1);
    }
    
    const [distDir, maxSizeKB] = args;
    const checker = new BundleSizeChecker(distDir, parseInt(maxSizeKB));
    
    const report = checker.generateReport();
    
    console.log(`Bundle Size Validation: ${report.status}`);
    
    if (report.errors && report.errors.length > 0) {
        console.log('❌ Errors:');
        report.errors.forEach(error => console.log(`  - ${error}`));
    }
    
    if (report.warnings && report.warnings.length > 0) {
        console.log('⚠️ Warnings:');
        report.warnings.forEach(warning => console.log(`  - ${warning}`));
    }
    
    if (report.bundle) {
        const bundle = report.bundle;
        console.log('📦 Bundle Analysis:');
        console.log(`  Size: ${bundle.totalMB}MB (${bundle.totalKB}KB)`);
        console.log(`  Limit: ${bundle.maxSizeKB}KB`);
        console.log(`  Status: ${bundle.passed ? '✅ Within limit' : '❌ Exceeds limit'}`);
    }
    
    if (report.largestFiles && report.largestFiles.length > 0) {
        console.log('📊 Largest Files:');
        report.largestFiles.slice(0, 5).forEach((file, index) => {
            const relativePath = path.relative(process.cwd(), file.path);
            console.log(`  ${index + 1}. ${relativePath} (${file.sizeKB}KB)`);
        });
    }
    
    process.exit(report.status === 'PASS' ? 0 : 1);
}

if (require.main === module) {
    main();
}

module.exports = BundleSizeChecker;
```

## 5. Document Quality Report Generator

### generate-doc-report.py
```python
#!/usr/bin/env python3
"""
Document Quality Report Generator
Creates comprehensive documentation quality reports
"""

import re
import json
import argparse
from pathlib import Path
from datetime import datetime
from typing import Dict, List

class DocumentQualityReporter:
    def __init__(self, docs_dir: Path):
        self.docs_dir = docs_dir
        self.report_data = {}
    
    def analyze_document_structure(self) -> Dict:
        """Analyze document structure and completeness"""
        structure_analysis = {
            'requirements': self.analyze_requirements(),
            'specs': self.analyze_feature_specs(),
            'design': self.analyze_design_docs(),
            'decisions': self.analyze_adr_docs()
        }
        
        return structure_analysis
    
    def analyze_requirements(self) -> Dict:
        """Analyze requirements documents"""
        req_dir = self.docs_dir / 'requirements'
        if not req_dir.exists():
            return {'error': 'Requirements directory not found'}
        
        req_files = list(req_dir.glob('*.md'))
        
        analysis = {
            'total_files': len(req_files),
            'fr_ids': set(),
            'missing_sections': [],
            'quality_issues': []
        }
        
        required_sections = ['Overview', 'Scope', 'Functional Requirements', 'Non-Functional Requirements', 'Constraints']
        
        for file_path in req_files:
            content = file_path.read_text(encoding='utf-8')
            
            # Extract FR IDs
            fr_matches = re.findall(r'FR-\d{3}', content)
            analysis['fr_ids'].update(fr_matches)
            
            # Check for required sections
            for section in required_sections:
                if section not in content:
                    analysis['missing_sections'].append(f"{file_path.name}: Missing {section}")
            
            # Quality checks
            if len(content.split('\n')) < 10:
                analysis['quality_issues'].append(f"{file_path.name}: Document too short")
            
            if 'TODO' in content or 'FIXME' in content:
                analysis['quality_issues'].append(f"{file_path.name}: Contains TODO/FIXME")
        
        analysis['fr_ids'] = list(analysis['fr_ids'])
        return analysis
    
    def analyze_feature_specs(self) -> Dict:
        """Analyze feature specification documents"""
        specs_dir = self.docs_dir / 'specs'
        if not specs_dir.exists():
            return {'error': 'Specs directory not found'}
        
        spec_files = list(specs_dir.glob('*.md'))
        
        analysis = {
            'total_files': len(spec_files),
            'fs_ids': set(),
            'ui_specs_complete': 0,
            'missing_sections': [],
            'quality_issues': []
        }
        
        required_sections = ['UI Layout', 'Data Specification', 'Behavior Specification', 'Accessibility Specification']
        
        for file_path in spec_files:
            content = file_path.read_text(encoding='utf-8')
            
            # Extract FS IDs
            fs_matches = re.findall(r'FS-\d{3}', content)
            analysis['fs_ids'].update(fs_matches)
            
            # Check UI completeness
            ui_elements = ['Layout Structure', 'Visual Design', 'Animation', 'Responsive Design']
            if all(element in content for element in ui_elements):
                analysis['ui_specs_complete'] += 1
            
            # Check for required sections
            missing_sections = [section for section in required_sections if section not in content]
            if missing_sections:
                analysis['missing_sections'].append(f"{file_path.name}: Missing {', '.join(missing_sections)}")
        
        analysis['fs_ids'] = list(analysis['fs_ids'])
        return analysis
    
    def analyze_design_docs(self) -> Dict:
        """Analyze design documents"""
        design_dir = self.docs_dir / 'design'
        if not design_dir.exists():
            return {'error': 'Design directory not found'}
        
        design_files = list(design_dir.glob('*.md'))
        
        analysis = {
            'total_files': len(design_files),
            'd_ids': set(),
            'api_specs_complete': 0,
            'missing_sections': [],
            'quality_issues': []
        }
        
        for file_path in design_files:
            content = file_path.read_text(encoding='utf-8')
            
            # Extract D IDs
            d_matches = re.findall(r'D-\d{3}', content)
            analysis['d_ids'].update(d_matches)
            
            # Check API completeness
            if 'Public API' in content and '`' in content:
                analysis['api_specs_complete'] += 1
            
            # Check for component structure
            if 'Components (with D-ID)' not in content:
                analysis['missing_sections'].append(f"{file_path.name}: Missing D-ID components section")
        
        analysis['d_ids'] = list(analysis['d_ids'])
        return analysis
    
    def analyze_adr_docs(self) -> Dict:
        """Analyze ADR documents"""
        adr_dir = self.docs_dir / 'decisions'
        if not adr_dir.exists():
            return {'error': 'Decisions directory not found'}
        
        adr_files = list(adr_dir.glob('*.md'))
        
        analysis = {
            'total_files': len(adr_files),
            'adr_ids': set(),
            'status_distribution': {},
            'missing_sections': []
        }
        
        required_sections = ['Context', 'Decision', 'Consequences', 'Status']
        
        for file_path in adr_files:
            content = file_path.read_text(encoding='utf-8')
            
            # Extract ADR IDs
            adr_matches = re.findall(r'ADR-\d{3}', content)
            analysis['adr_ids'].update(adr_matches)
            
            # Extract status
            status_match = re.search(r'Status.*?:\s*(\w+)', content)
            if status_match:
                status = status_match.group(1)
                analysis['status_distribution'][status] = analysis['status_distribution'].get(status, 0) + 1
            
            # Check required sections
            missing_sections = [section for section in required_sections if section not in content]
            if missing_sections:
                analysis['missing_sections'].append(f"{file_path.name}: Missing {', '.join(missing_sections)}")
        
        analysis['adr_ids'] = list(analysis['adr_ids'])
        return analysis
    
    def generate_quality_score(self, structure_analysis: Dict) -> Dict:
        """Generate overall quality score"""
        total_score = 0
        max_score = 0
        
        # Requirements scoring
        req_analysis = structure_analysis.get('requirements', {})
        if 'error' not in req_analysis:
            req_score = max(0, 10 - len(req_analysis.get('missing_sections', [])) - len(req_analysis.get('quality_issues', [])))
            total_score += req_score
        max_score += 10
        
        # Feature specs scoring
        specs_analysis = structure_analysis.get('specs', {})
        if 'error' not in specs_analysis:
            specs_score = max(0, 10 - len(specs_analysis.get('missing_sections', [])))
            total_score += specs_score
        max_score += 10
        
        # Design scoring
        design_analysis = structure_analysis.get('design', {})
        if 'error' not in design_analysis:
            design_score = max(0, 10 - len(design_analysis.get('missing_sections', [])))
            total_score += design_score
        max_score += 10
        
        # ADR scoring
        adr_analysis = structure_analysis.get('decisions', {})
        if 'error' not in adr_analysis:
            adr_score = max(0, 10 - len(adr_analysis.get('missing_sections', [])))
            total_score += adr_score
        max_score += 10
        
        overall_score = (total_score / max_score * 100) if max_score > 0 else 0
        
        return {
            'overall_score': round(overall_score, 1),
            'total_score': total_score,
            'max_score': max_score,
            'grade': self.get_grade(overall_score)
        }
    
    def get_grade(self, score: float) -> str:
        """Convert score to letter grade"""
        if score >= 95:
            return 'A+'
        elif score >= 90:
            return 'A'
        elif score >= 85:
            return 'B+'
        elif score >= 80:
            return 'B'
        elif score >= 75:
            return 'C+'
        elif score >= 70:
            return 'C'
        elif score >= 65:
            return 'D+'
        elif score >= 60:
            return 'D'
        else:
            return 'F'
    
    def generate_markdown_report(self) -> str:
        """Generate markdown report"""
        structure_analysis = self.analyze_document_structure()
        quality_score = self.generate_quality_score(structure_analysis)
        
        report = f"""# Documentation Quality Report

**Generated**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

## Overall Quality Score: {quality_score['overall_score']}/100 ({quality_score['grade']})

---

## 📋 Requirements Analysis
"""
        
        req_analysis = structure_analysis.get('requirements', {})
        if 'error' in req_analysis:
            report += f"❌ {req_analysis['error']}\n\n"
        else:
            report += f"""
- **Total Files**: {req_analysis['total_files']}
- **FR IDs Found**: {len(req_analysis['fr_ids'])}
- **Missing Sections**: {len(req_analysis['missing_sections'])}
- **Quality Issues**: {len(req_analysis['quality_issues'])}

"""
            if req_analysis['missing_sections']:
                report += "### Missing Sections:\n"
                for issue in req_analysis['missing_sections']:
                    report += f"- {issue}\n"
                report += "\n"
        
        report += "## 📝 Feature Specifications Analysis\n"
        
        specs_analysis = structure_analysis.get('specs', {})
        if 'error' in specs_analysis:
            report += f"❌ {specs_analysis['error']}\n\n"
        else:
            report += f"""
- **Total Files**: {specs_analysis['total_files']}
- **FS IDs Found**: {len(specs_analysis['fs_ids'])}
- **Complete UI Specs**: {specs_analysis['ui_specs_complete']}/{specs_analysis['total_files']}
- **Missing Sections**: {len(specs_analysis['missing_sections'])}

"""
        
        report += "## 🎨 Design Documents Analysis\n"
        
        design_analysis = structure_analysis.get('design', {})
        if 'error' in design_analysis:
            report += f"❌ {design_analysis['error']}\n\n"
        else:
            report += f"""
- **Total Files**: {design_analysis['total_files']}
- **D IDs Found**: {len(design_analysis['d_ids'])}
- **Complete API Specs**: {design_analysis['api_specs_complete']}/{design_analysis['total_files']}
- **Missing Sections**: {len(design_analysis['missing_sections'])}

"""
        
        report += "## 🏛️ Architecture Decisions Analysis\n"
        
        adr_analysis = structure_analysis.get('decisions', {})
        if 'error' in adr_analysis:
            report += f"❌ {adr_analysis['error']}\n\n"
        else:
            report += f"""
- **Total Files**: {adr_analysis['total_files']}
- **ADR IDs Found**: {len(adr_analysis['adr_ids'])}
- **Status Distribution**: {adr_analysis['status_distribution']}
- **Missing Sections**: {len(adr_analysis['missing_sections'])}

"""
        
        report += """---

## Recommendations

"""
        
        # Generate recommendations based on analysis
        recommendations = self.generate_recommendations(structure_analysis)
        for rec in recommendations:
            report += f"- {rec}\n"
        
        return report
    
    def generate_recommendations(self, structure_analysis: Dict) -> List[str]:
        """Generate improvement recommendations"""
        recommendations = []
        
        # Requirements recommendations
        req_analysis = structure_analysis.get('requirements', {})
        if 'error' not in req_analysis:
            if req_analysis.get('quality_issues'):
                recommendations.append("📋 Address quality issues in requirements documents")
            if len(req_analysis.get('fr_ids', [])) == 0:
                recommendations.append("📋 Add proper FR-XXX identifiers to requirements")
        
        # Feature specs recommendations
        specs_analysis = structure_analysis.get('specs', {})
        if 'error' not in specs_analysis:
            ui_completion_rate = specs_analysis.get('ui_specs_complete', 0) / max(specs_analysis.get('total_files', 1), 1)
            if ui_completion_rate < 0.8:
                recommendations.append("📝 Complete UI specifications in feature specs")
        
        # Design recommendations
        design_analysis = structure_analysis.get('design', {})
        if 'error' not in design_analysis:
            api_completion_rate = design_analysis.get('api_specs_complete', 0) / max(design_analysis.get('total_files', 1), 1)
            if api_completion_rate < 0.8:
                recommendations.append("🎨 Add public API specifications to design documents")
        
        if not recommendations:
            recommendations.append("✅ Documentation quality is excellent!")
        
        return recommendations

def main():
    parser = argparse.ArgumentParser(description='Generate documentation quality report')
    parser.add_argument('--docs-dir', default='docs', help='Documentation directory')
    parser.add_argument('--json', action='store_true', help='Output JSON instead of markdown')
    
    args = parser.parse_args()
    
    reporter = DocumentQualityReporter(Path(args.docs_dir))
    
    if args.json:
        structure_analysis = reporter.analyze_document_structure()
        quality_score = reporter.generate_quality_score(structure_analysis)
        
        report_data = {
            'timestamp': datetime.now().isoformat(),
            'quality_score': quality_score,
            'analysis': structure_analysis,
            'recommendations': reporter.generate_recommendations(structure_analysis)
        }
        
        print(json.dumps(report_data, indent=2))
    else:
        markdown_report = reporter.generate_markdown_report()
        print(markdown_report)

if __name__ == '__main__':
    main()
```

## Usage Instructions

1. **Make scripts executable**:
```bash
chmod +x scripts/*.py
chmod +x scripts/*.js
```

2. **Install dependencies**:
```bash
# Python dependencies
pip install -r requirements.txt

# Node.js dependencies  
npm install
```

3. **Run in CI pipeline**:
```yaml
- name: Validate traceability
  run: python scripts/validate-traceability.py docs/trace.md

- name: Check test tags
  run: python scripts/validate-test-tags.py src/

- name: Verify coverage
  run: node scripts/check-coverage-threshold.js coverage/coverage-summary.json 90

- name: Check bundle size
  run: node scripts/check-bundle-size.js dist/ 2048
```