# git-report
Creating project report based on git commits matching [Conventional Commits](https://www.conventionalcommits.org) guidlines.

## How to use
`./git-report.sh 2024-01-23 2024-02-29 master`

### Parameters
| Name | Description                                       |   Default  |
| ---- | ------------------------------------------------- | ---------- |
|  $1  | Branch name for the report is generated           | master     |
|  $2  | Date/DateTime value since the report is generated | 2 week ago |
|  $3  | Date/DateTime value until the report is generated | today      |

## Generated report
```
┌───────────────────────────┐
│ Report on commits         │
│  on branch         master │
│       from     2 week ago │
│         to          today │
│                           │
│ Commit type       │ Count │
├───────────────────┼───────┤
│ Breaking          │     0 │
│ Breaking*         │     0 │
│ Feature           │     8 │
│ Fix               │     6 │
│ Test              │     2 │
│ Other             │     7 │
│ Build             │     1 │
│ CI                │     1 │
│ Documentation     │     0 │
│ Refactor          │    18 │
├───────────────────┼───────┤
│ Total             │    43 │
└───────────────────┴───────┘
```

## Known issues
- Commits that have type keyword as scope is counted as type. E.g.: `fix(test): prevent failing prevent racing of requests` will result in +1 for both `fix` and `test`.
