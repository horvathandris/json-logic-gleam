import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam_community/ansi
import suite

pub fn test_report(
  results: dict.Dict(String, List(#(String, suite.TestCaseResult))),
) {
  use suite, test_results <- dict.each(results)
  {
    "\n"
    <> suite
    <> " - "
    <> count_passed(test_results)
    <> "/"
    <> count_all(test_results)
  }
  |> ansi.bold
  |> ansi.underline
  |> io.println
  use #(test_description, test_result) <- list.each(test_results)
  {
    ansi.bold(test_description <> ": ")
    <> test_case_result_to_string(test_result)
  }
  |> io.println
}

fn test_case_result_to_string(test_result: suite.TestCaseResult) -> String {
  case test_result {
    suite.Passed -> ansi.green("Passed")
    suite.Failed -> ansi.red("Failed")
  }
}

fn count_passed(test_results: List(#(a, suite.TestCaseResult))) -> String {
  list.count(test_results, fn(result) { result.1 == suite.Passed })
  |> int.to_string
}

fn count_all(test_results: List(a)) -> String {
  list.length(test_results)
  |> int.to_string
}
