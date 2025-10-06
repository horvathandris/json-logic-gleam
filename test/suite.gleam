import filepath
import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/json
import gleam/list
import gleam/option.{type Option}
import gleam/result
import jsonlogic
import simplifile

pub type TestCase {
  TestCase(
    description: String,
    logic: Dynamic,
    data: Option(Dynamic),
    result: ExpectedResult,
    error: Option(Dynamic),
  )
}

pub type ExpectedResult {
  NoResult
  SomeResult(Dynamic)
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
  let actual = jsonlogic.apply(test_case.logic)
  // echo actual

  let test_case_result = case test_case.result {
    SomeResult(expected) ->
      case actual == Ok(expected) {
        True -> Passed
        False -> Failed
      }
    NoResult -> panic as "Test case without result is not supported yet"
  }

  #(test_case.description, test_case_result)
}

fn normalize_dynamic(value: Dynamic) -> Dynamic {
  case dynamic.classify(value) {
    "Nil" -> dynamic.nil()
    _ -> value
  }
}

fn test_case_decoder() {
  use description <- decode.field("description", decode.string)
  use logic <- decode.field("rule", decode.dynamic)
  use data <- decode.optional_field(
    "data",
    option.None,
    decode.optional(decode.dynamic),
  )
  use result <- decode.optional_field(
    "result",
    NoResult,
    decode.dynamic
      |> decode.map(normalize_dynamic)
      |> decode.map(SomeResult),
  )
  use error <- decode.optional_field(
    "error",
    option.None,
    decode.optional(decode.dynamic),
  )
  TestCase(description:, logic:, data:, result:, error:)
  |> decode.success
}

pub type TestSuite {
  TestSuite(name: String, test_cases: List(TestCase))
}

pub fn load_test_suites(suites_directory: String) -> List(TestSuite) {
  // load all suites from "../suites/index.json"
  let assert Ok(suites_directory) =
    do_find_root(".")
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

fn do_find_root(path: String) -> Result(String, simplifile.FileError) {
  let manifest = filepath.join(path, "gleam.toml")
  case simplifile.is_file(manifest) {
    Ok(True) -> Ok(path)
    Ok(False) -> do_find_root(filepath.join(path, ".."))
    Error(reason) -> Error(reason)
  }
}
