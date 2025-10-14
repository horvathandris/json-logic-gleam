import gleam/dynamic
import gleam/result
import jsonlogic/error
import jsonlogic/internal/decoding
import jsonlogic/internal/evaluation

/// Apply a JSONLogic rule to dynamic data.
///
/// This function parses the string rule via `json.parse` and then
/// evaluates it using `jsonlogic.apply_dynamic`.
///
/// ## Examples
///
/// ```gleam
/// jsonlogic.apply(
///   "{ \"var\" : \"a\" }",
///   dynamic.properties([
///     #(dynamic.string("a"), dynamic.int(1)),
///     #(dynamic.string("b"), dynamic.int(2)),
///   ]),
/// )
/// // -> 1
/// ```
///
pub fn apply(
  rule: String,
  to data: dynamic.Dynamic,
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  decoding.decode_rule_string(rule)
  |> result.try(evaluation.evaluate(_, data))
}

/// Apply a dynamic JSONLogic rule to dynamic data.
///
/// This function should be used when the rule is already parsed via `json.parse`
/// or other means.
///
/// ## Examples
///
/// ```gleam
/// let rules =
///   "
///   { \"and\" : [
///     {\"<\" : [ { \"var\" : \"temp\" }, 110 ]},
///     {\"==\" : [ { \"var\" : \"pie.filling\" }, \"apple\" ] }
///   ] }
///   "
///
/// let data =
///   dynamic.properties([
///     #(dynamic.string("temp"), dynamic.int(100)),
///     #(
///       dynamic.string("pie"),
///       dynamic.properties([
///         #(dynamic.string("filling"), dynamic.string("apple")),
///       ]),
///     ),
///   ])
///
/// use parsed_rules <- result.map(json.parse(rules, decode.dynamic))
/// jsonlogic.apply_dynamic(parsed_rules, data)
/// // -> Ok(True)
/// ```
///
pub fn apply_dynamic(
  rule: dynamic.Dynamic,
  to data: dynamic.Dynamic,
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  decoding.decode_rule(rule)
  |> result.try(evaluation.evaluate(_, data))
}
