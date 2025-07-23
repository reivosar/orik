# Spec-Driven Development DSL for Claude
# Claude自身が作成した仕様書を使って実装するためのフレームワーク

## CORE_PRINCIPLES
- Claude自身が読みやすく理解しやすい仕様書を作成
- 実装に必要な全詳細を含む設計書
- 検証可能な実装計画
- 段階的な品質チェック

## DOCUMENT_TEMPLATES

### REQUIREMENTS_TEMPLATE
```
# Requirements Document

## 1. プロジェクト概要
- **目的**: [1行で目的を記述]
- **対象ユーザー**: [想定ユーザーを記述]
- **スコープ**: [プロジェクトの範囲を明確化]

## 2. 機能要件
### 2.1 主要機能
- [ ] 機能1: [具体的な動作を記述]
- [ ] 機能2: [具体的な動作を記述]

### 2.2 非機能要件
- **パフォーマンス**: [性能要件]
- **セキュリティ**: [セキュリティ要件]
- **可用性**: [可用性要件]

## 3. 制約条件
- [技術的制約]
- [時間的制約]
- [リソース制約]

## 4. 成功基準
- [ ] 基準1: [測定可能な基準]
- [ ] 基準2: [測定可能な基準]
```

### DESIGN_TEMPLATE  
```
# Design Document

## 1. アーキテクチャ概要
- **アプリケーションタイプ**: [Web/CLI/Desktop/API/Library/Mobile/Microservice/Batch等]
- **アーキテクチャパターン**: [MVC/Layered/Microservices/Event-Driven等]
- **主要技術スタック**: [使用技術一覧]

### 1.1 アプリケーションタイプ別要件
LOAD app-types.dsl FOR TYPE-SPECIFIC VALIDATION RULES

### 1.2 セキュリティ要件
LOAD security-rules.dsl FOR SECURITY REQUIREMENTS BY PRIORITY

## 2. システム設計
### 2.1 ディレクトリ構成
```
project/
├── src/
│   ├── components/
│   ├── services/
│   └── utils/
├── tests/
└── docs/
```

### 2.2 主要コンポーネント
#### ComponentA
- **責務**: [コンポーネントの役割]
- **インターフェース**: [API定義]
- **依存関係**: [他コンポーネントとの関係]

### 2.3 データフロー
1. [ステップ1の詳細]
2. [ステップ2の詳細]
3. [ステップ3の詳細]

## 3. 実装詳細
### 3.1 ファイル別実装内容
- `src/main.js`: [このファイルの実装内容]
- `src/utils.js`: [このファイルの実装内容]

### 3.2 エラーハンドリング戦略
- [エラー処理方針]
- [ログ出力方針]

## 4. テスト戦略
- **単体テスト**: [対象と方法]
- **統合テスト**: [対象と方法]
```

### TASKS_TEMPLATE
```
# Implementation Tasks

## タスク一覧

### Phase 1: 基盤構築
- [ ] Task 1.1: プロジェクト初期化
  - **詳細**: package.json作成、依存関係インストール
  - **成果物**: `package.json`, `node_modules/`
  - **所要時間**: 5分
  - **完了条件**: npm install が正常実行される

### Phase 2: 主要機能実装
- [ ] Task 2.1: [具体的なタスク名]
  - **詳細**: [実装する内容の詳細]
  - **ファイル**: [作成・編集するファイル一覧]
  - **成果物**: [作成される具体的なファイル・機能]
  - **依存**: [前提となるタスク]
  - **完了条件**: [テスト可能な完了条件]

## 品質チェックポイント
### 各Phase完了時チェック
- [ ] コードの構文チェック完了
- [ ] 基本動作テスト完了
- [ ] エラーハンドリング実装完了

### 最終チェック
- [ ] 全機能動作確認完了
- [ ] パフォーマンステスト完了
- [ ] セキュリティチェック完了
```

## CLAUDE_EXECUTION_FLOW

### PHASE_1_REQUIREMENTS
1. ユーザーの要求を受取り
2. REQUIREMENTS_TEMPLATEに従って requirements.md を作成
3. ユーザーに確認・修正を求める
4. requirements.md を確定

### PHASE_2_DESIGN  
1. requirements.md を詳細に分析
2. DESIGN_TEMPLATEに従って design.md を作成
3. 実装に必要な全詳細を含める
4. ユーザーに確認・修正を求める
5. design.md を確定

### PHASE_3_TASKS
1. design.md から具体的なタスクを抽出
2. TASKS_TEMPLATEに従って tasks.md を作成
3. 各タスクに詳細な実装指針を含める
4. 依存関係と順序を明確化
5. tasks.md を確定

### PHASE_4_IMPLEMENTATION
1. tasks.md の順序に従って実装開始
2. 各タスク完了時に品質チェック実行
3. チェック失敗時は前段階に戻って修正
4. 全タスク完了まで継続

## QUALITY_CONTROL
Execute relevant checklist from checklist.dsl at the completion of each phase