
#!/bin/sh
# @file git-statistics
# @brief A library that generated report based on git history.
# @description The library expects commit messages matching Conventional Commits guidelines
# @arg $1 string Branch name for the report is generated
# @arg $2 string Date/DateTime value since the report is generated
# @arg $3 string Date/DateTime value until the report is generated

# Parameters
INSPECTED_BRANCH=${1: -"master"}
SINCE=${2:-"2 week ago"}
UNTIL=${3:-"today"}

# Watched commit types
TYPES=(
  'Breaking:perf'
  'Breaking*:BREAKING'
  'Feature:feat'
  'Fix:fix'
  'Test:test'
  'Other:chore'
  'Build:build'
  'CI:ci'
  'Documentation:docs'
  'Refactor:refactor'
)

# Report generation
total=$(git log $INSPECTED_BRANCH --oneline --since="$SINCE" --until="$UNTIL" | wc -l)

printf "┌───────────────────────────┐\n"
printf "│ Report on commits         │\n"
printf "│ %10s   %12s │\n" "from" "$SINCE"
printf "│ %10s   %12s │\n" "to" "$UNTIL"
printf "│ %-25s │\n" " "
printf "│ %-17s │ %5s │\n" "Commit type" "Count"
printf "├───────────────────┼───────┤\n"

for item in "${TYPES[@]}"
do
  IFS=':' read -ra parts <<< "$item"
  name=${parts[0]}
  type=${parts[1]}

  pattern="/.*$\b$type.*:.*$/"
  count=$(git log $INSPECTED_BRANCH --oneline --since="$SINCE" --until="$UNTIL" | grep ".*$type.*:.*$" | wc -l)
  printf "│ %-17s │ %5d │\n" $name $count
done

printf "├───────────────────┼───────┤\n"
printf "│ %-17s │ %5s │\n" "Total" $total
printf "└───────────────────┴───────┘\n"
