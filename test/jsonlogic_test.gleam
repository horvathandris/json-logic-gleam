import gleam/list
import gleeunit
import suite

pub fn main() {
  gleeunit.main()
}

pub fn run_test_suites__test() {
  use test_suite <- list.map(suite.load_test_suites("suites-basic"))

  echo test_suite.name

  suite.run_test_cases(test_suite)
}
