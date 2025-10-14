import gleam/dict
import gleam/list
import gleeunit
import reporting
import suite

pub fn main() {
  gleeunit.main()
}

pub fn run_test_suites__test() {
  suite.load_test_suites("suites")
  |> collect_test_results
  |> reporting.produce_test_report
}

fn collect_test_results(
  test_suites: List(suite.TestSuite),
) -> dict.Dict(String, List(#(String, suite.TestCaseResult))) {
  use results, test_suite <- list.fold(test_suites, dict.new())

  results
  |> dict.insert(test_suite.name, suite.run_test_cases(test_suite))
}
