import gleam/dynamic
import gleam/dynamic/decode
import gleam/float
import gleam/int
import gleam/list
import gleam/result
import jsonlogic/error
import jsonlogic/internal/decoding

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

pub fn divide(a: Float, b: Float) -> Result(Float, error.EvaluationError) {
  float.divide(a, b)
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

pub fn flatten(values: List(dynamic.Dynamic)) -> List(dynamic.Dynamic) {
  use value <- list.flat_map(values)
  let assert Ok(decoded) =
    decode.run(
      value,
      decode.one_of(decode.list(decode.dynamic), or: [
        decode.map(decode.dynamic, list.wrap),
      ]),
    )
  decoded
}

pub fn normalize_dynamic(value: dynamic.Dynamic) -> dynamic.Dynamic {
  case dynamic.classify(value) {
    "Nil" -> dynamic.nil()
    _ -> value
  }
}

pub fn loose_equals(
  first: dynamic.Dynamic,
  second: dynamic.Dynamic,
) -> Result(Bool, error.EvaluationError) {
  case dynamic.classify(first), dynamic.classify(second) {
    x, y if x == y -> Ok(first == second)

    "Bool", _ -> {
      let assert Ok(first) = decode.run(first, decode.bool)
      decoding.bool_to_float(first)
      |> dynamic.float
      |> loose_equals(second)
    }
    _, "Bool" -> {
      let assert Ok(second) = decode.run(second, decode.bool)
      decoding.bool_to_float(second)
      |> dynamic.float
      |> loose_equals(first)
    }
    "Int", "String"
    | "Float", "String"
    | "String", "Float"
    | "String", "Int"
    | "Float", "Int"
    | "Int", "Float"
    -> {
      use first <- result.try(decoding.dynamic_to_float(first))
      use second <- result.map(decoding.dynamic_to_float(second))
      dynamic.float(first) == dynamic.float(second)
    }
    "Nil", _ -> Ok(dynamic.nil() == second)
    _, "Nil" -> Ok(dynamic.nil() == first)
    _, _ -> Ok(False)
  }
}
