import gleam/dynamic
import gleam/result
import jsonlogic/error
import jsonlogic/internal/decoding
import jsonlogic/internal/evaluation

/// Apply a JSONLogic rule to dynamic data.
///
/// ## Examples
///
/// ```gleam
/// jsonlogic.apply(
///	  "{ \"var\" : \"a\" },
///	  dynamic.properties([
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
/// ## Examples
///
/// ```gleam
/// let rules =
///   dynamic.properties([
///     #(
///       dynamic.string("and"),
///       dynamic.list([
///         dynamic.properties([
///           #(
///             dynamic.string("<"),
///             dynamic.list([
///               dynamic.properties([
///                 #(dynamic.string("var"), dynamic.string("temp")),
///               ]),
///               dynamic.int(110),
///             ]),
///           ),
///           #(
///             dynamic.string("=="),
///             dynamic.list([
///               dynamic.properties([
///                 #(dynamic.string("var"), dynamic.string("pie.filling")),
///               ]),
///               dynamic.string("apple"),
///             ]),
///           ),
///         ]),
///       ]),
///     ),
///   ])
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
/// jsonlogic.apply(rules, data);
/// // -> True
/// ```
///
pub fn apply_dynamic(
  rule: dynamic.Dynamic,
  to data: dynamic.Dynamic,
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  decoding.decode_rule(rule)
  |> result.try(evaluation.evaluate(_, data))
}
