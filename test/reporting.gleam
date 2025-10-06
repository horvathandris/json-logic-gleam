import gleam/dict
import gleam/io
import gleam/list
import gleam_community/ansi
import suite

pub fn test_report(
  results: dict.Dict(String, List(#(String, suite.TestCaseResult))),
) {
  use suite, test_results <- dict.each(results)
  { "\n" <> suite }
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
