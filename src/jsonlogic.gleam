import gleam/dynamic.{type Dynamic}
import gleam/io
import gleam/json
import jsonlogic/decoding
import jsonlogic/evaluation

pub fn main() -> Nil {
  io.println("Hello from jsonlogic!")
}

pub fn apply(rule: Dynamic) -> Result(json.Json, evaluation.EvaluationError) {
  let assert Ok(typed_rule) = decoding.decode_rule(rule)
  evaluation.evaluate(typed_rule)
}
