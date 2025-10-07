import gleam/dynamic
import gleam/float
import gleam/int
import gleam/list
import gleam/result
import jsonlogic/internal/error

pub fn comparison_reduce(
  values: List(Float),
  operator: fn(Float, Float) -> Bool,
) -> Result(Bool, error.EvaluationError) {
  case values {
    [first, ..rest] ->
      list.fold_until(rest, #(first, True), fn(previous, current) {
        case operator(previous.0, current) {
          True -> list.Continue(#(current, True))
          False -> list.Stop(#(current, False))
        }
      })
      |> fn(res) { Ok(res.1) }

    _ -> Error(error.InvalidArgumentsError)
  }
}

pub fn chain_reduce(
  values: List(Float),
  operator: fn(Float, Float) -> Float,
) -> Result(Float, error.EvaluationError) {
  case values {
    [first, ..rest] -> Ok(list.fold(rest, first, operator))
    _ -> Error(error.InvalidArgumentsError)
  }
}

pub fn chain_reduce_result(
  values: List(Float),
  operator: fn(Float, Float) -> Result(Float, error.EvaluationError),
) -> Result(Float, error.EvaluationError) {
  case values {
    [first, ..rest] ->
      list.fold_until(rest, Ok(first), fn(previous, current) {
        let assert Ok(previous) = previous
        case operator(previous, current) {
          Ok(result) -> list.Continue(Ok(result))
          Error(error) -> list.Stop(Error(error))
        }
      })
    _ -> Error(error.InvalidArgumentsError)
  }
}

pub fn modulo(a: Float, b: Float) -> Result(Float, error.EvaluationError) {
  float.modulo(float.absolute_value(a), float.absolute_value(b))
  |> result.map(fn(value) {
    case a <. 0.0, b <. 0.0 {
      True, False -> float.negate(value)
      _, _ -> value
    }
  })
  |> result.try_recover(fn(_) { Error(error.NaNError) })
}

pub fn float_to_dynamic(value: Float) -> dynamic.Dynamic {
  let truncated = float.truncate(value)
  let is_zero = is_zero(value)
  case value == int.to_float(truncated) {
    True -> dynamic.int(truncated)
    False if is_zero -> dynamic.int(0)
    False -> dynamic.float(value)
  }
}

fn is_zero(value: Float) -> Bool {
  case value == 0.0, value == -0.0 {
    True, _ | _, True -> True
    _, _ -> False
  }
}
