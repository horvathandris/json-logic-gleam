import gleam/dynamic
import gleam/result
import jsonlogic/internal/decoding
import jsonlogic/internal/error
import jsonlogic/internal/evaluation

pub fn apply(
  rule: dynamic.Dynamic,
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  decoding.decode_rule(rule)
  |> result.try(evaluation.evaluate)
}
