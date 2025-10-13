import gleam/dynamic
import gleam/result
import jsonlogic/error
import jsonlogic/internal/decoding
import jsonlogic/internal/evaluation

pub fn apply(
  rule: String,
  to data: dynamic.Dynamic,
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  decoding.decode_rule_string(rule)
  |> result.try(evaluation.evaluate(_, data))
}

pub fn apply_dynamic(
  rule: dynamic.Dynamic,
  to data: dynamic.Dynamic,
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  decoding.decode_rule(rule)
  |> result.try(evaluation.evaluate(_, data))
}
