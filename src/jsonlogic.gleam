import gleam/dynamic
import gleam/io
import gleam/result
import jsonlogic/decoding
import jsonlogic/evaluation

pub fn apply(
  rule: dynamic.Dynamic,
) -> Result(dynamic.Dynamic, evaluation.EvaluationError) {
  decoding.decode_rule(rule)
  |> result.try(evaluation.evaluate)
}
