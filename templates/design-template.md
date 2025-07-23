# Design Document

## 0. Meta
- Linked Requirements: v0.1
- Doc Version: 0.1 ({{DATE}})
- **D-ID Rules**: D-xxx IDs cannot be reused, mark as Deprecated instead of deletion

## 1. Overview
[Tech stack & architectural approach in 2-3 sentences]

## 2. Architecture / Data Flow
[Main processing loop and state update flow in one paragraph or pseudocode]
[External dependencies (API/storage) if any]

### State Transitions (if applicable)
[Main state flow: INIT → READY → RUNNING/PAUSED → RESET → ...]

## 3. Components (with D-ID)

### D-001: [ComponentName] (FR-001, FR-004)
- **Responsibility**: [What this component manages]
- **Public API**:
  - `method(arg: Type): ReturnType`
  - `anotherMethod(param: Type): void`
- **Depends on**: [modules/libraries]

### D-002: [ComponentName] (FR-002)
- **Responsibility**: [What this component does]
- **Public API**:
  - `publicMethod(input: Type): OutputType`
  - `eventHandler(): void`
- **Depends on**: [dependencies]

[Continue with D-003, D-004, etc.]

## 4. Data Models
```typescript
interface Entity {
  id: string; // UUID
  [property]: [type]; // [constraints]
  [optional]?: [type]; // [description]
}

interface AnotherEntity {
  // [Required types/schemas only]
}
```

## 5. Event → Handler Map

| Event / Trigger | Handler / Module |
|----------------|------------------|
| Click [element] | ComponentName.method() |
| Slider change (speed) | SimulationController.setSpeed() |
| Window resize | LayoutManager.onResize() |
| [event] | [handler] |

## 6. Error / Fallback Policy
- **[Failure case]** → [handling approach]
- **WebGL not supported** → [fallback display content]
- **Network timeout** → [retry/offline behavior]
- **[error scenario]** → [recovery strategy]

### Cleanup / Dispose Policy
- **Event listeners**: [timing and method for removal]
- **Memory cleanup**: [policy for releasing WebGL/large objects]
- **Timers/intervals**: [stopping and cleanup timing]

## 7. Test Hooks / Strategy
- **Unit**: [calculation/logic modules to test]
- **Integration**: [main flow components]
- **E2E**: [key user scenarios]

## 8. Open Questions / TODO
- [Unresolved decisions]
- [Implementation TODOs]
- [Research items]

**Note**: Open Questions should be migrated to GitHub Issues

---

## CI/Lint Regular Expressions (Reference)
```
# D-ID:   ^### D-\d{3}:
# API line: ^\s+- `\w+\(.*\): .+`
```