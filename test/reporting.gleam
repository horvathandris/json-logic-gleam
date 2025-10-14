import gleam/dict
import gleam/int
import gleam/list
import gleam/string
import gleam/string_tree
import simplifile
import suite
import test_util

pub fn produce_test_report(
  results: dict.Dict(String, List(#(String, suite.TestCaseResult))),
) {
  let assert Ok(project_root) = test_util.do_find_root(".")
  test_report(results)
  |> string_tree.to_string
  |> simplifile.write(to: project_root <> "/test/REPORT.md")
}

fn test_report(
  results: dict.Dict(String, List(#(String, suite.TestCaseResult))),
) {
  use report_contents, suite, test_results <- dict.fold(
    results,
    string_tree.new(),
  )

  let suite_header =
    "# "
    <> suite
    <> " — "
    <> count_passed(test_results)
    <> "/"
    <> count_all(test_results)
    <> " passed\n\n"

  let table_header = "| Test | Result |\n|------|--------|\n"

  let table_rows =
    list.map(test_results, fn(result) {
      "| " <> result.0 <> " | " <> test_case_result_to_string(result.1) <> " |"
    })
    |> string.join("\n")

  string_tree.append(
    report_contents,
    suite_header <> table_header <> table_rows <> "\n\n",
  )
}

fn test_case_result_to_string(test_result: suite.TestCaseResult) -> String {
  case test_result {
    suite.Passed -> "✅"
    suite.Failed -> "❌"
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
