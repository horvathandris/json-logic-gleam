import filepath
import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/json
import gleam/list
import gleam/result
import jsonlogic
import jsonlogic/error
import jsonlogic/internal/util
import simplifile
import test_util

pub type TestCase {
  TestCase(
    description: String,
    logic: Dynamic,
    data: Dynamic,
    result: ExpectedResult,
    error: ExpectedError,
  )
}

pub type ExpectedResult {
  NoResult
  SomeResult(Dynamic)
}

pub type ExpectedError {
  NoError
  SomeError(error.EvaluationError)
}

pub type TestCaseResult {
  Passed
  Failed
}

pub fn run_test_cases(suite: TestSuite) -> List(#(String, TestCaseResult)) {
  list.map(suite.test_cases, run_test_case)
}

pub fn run_test_case(test_case: TestCase) -> #(String, TestCaseResult) {
  // echo test_case
  let actual = jsonlogic.apply_dynamic(test_case.logic, test_case.data)
  // echo actual

  let test_case_result = case test_case.result {
    SomeResult(expected) ->
      case actual == Ok(expected) {
        True -> Passed
        False -> Failed
      }
    NoResult -> {
      case test_case.error {
        NoError ->
          panic as "The test case has no expected result or expected error"
        SomeError(e) ->
          case Error(e) == actual {
            True -> Passed
            False -> Failed
          }
      }
    }
  }

  #(test_case.description, test_case_result)
}

fn test_case_decoder() {
  use description <- decode.field("description", decode.string)
  use logic <- decode.field("rule", decode.dynamic)
  use data <- decode.optional_field("data", dynamic.nil(), decode.dynamic)
  use result <- decode.optional_field(
    "result",
    NoResult,
    decode.dynamic
      |> decode.map(util.normalize_dynamic)
      |> decode.map(SomeResult),
  )
  use error <- decode.optional_field("error", NoError, error_decoder())
  TestCase(description:, logic:, data:, result:, error:)
  |> decode.success
}

fn error_decoder() {
  use error_type <- decode.field("type", decode.string)
  case error_type {
    "NaN" -> SomeError(error.NaNError)
    "Invalid Arguments" -> SomeError(error.InvalidArgumentsError)
    e -> SomeError(error.CustomError(e))
  }
  |> decode.success
}

pub type TestSuite {
  TestSuite(name: String, test_cases: List(TestCase))
}

pub fn load_test_suites(suites_directory: String) -> List(TestSuite) {
  // load all suites from "../suites/index.json"
  let assert Ok(suites_directory) =
    test_util.do_find_root(".")
    |> result.map(filepath.join(_, suites_directory))

  let assert Ok(suites_file) =
    filepath.join(suites_directory, "index.json")
    |> simplifile.read

  let assert Ok(suite_files) =
    json.parse(suites_file, decode.list(of: decode.string))

  let suite_file_paths =
    list.map(suite_files, filepath.join(suites_directory, _))

  parse_test_suites(suite_file_paths)
}

fn parse_test_suites(suite_file_paths: List(String)) -> List(TestSuite) {
  use suite_file_path <- list.map(suite_file_paths)
  let assert Ok(suite_file) = simplifile.read(suite_file_path)

  let assert Ok(suite_dynamic) =
    json.parse(suite_file, decode.list(of: decode.dynamic))

  parse_test_cases(suite_dynamic)
  |> TestSuite(suite_file_path, _)
}

fn parse_test_cases(suite: List(Dynamic)) -> List(TestCase) {
  use test_case <- list.filter_map(suite)
  case dynamic.classify(test_case) {
    "Dict" ->
      decode.run(test_case, test_case_decoder())
      |> result.map_error(fn(_) { Nil })
    _ -> Error(Nil)
  }
}
