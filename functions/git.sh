diffo() {
  # This will diff a branch with it's origin `diffo master`
  git diff ${1}..origin/${1}
}

gnb() {
  # Create new branch
  git checkout -b ${1} && echo Branch ${1} Created, Round 1, Fight
}