import gleam/dynamic
import gleam/dynamic/decode
import gleam/float
import gleam/int
import gleam/list
import gleam/result
import jsonlogic/internal/error

pub fn dynamic_to_float(
  input: dynamic.Dynamic,
) -> Result(Float, error.EvaluationError) {
  case dynamic.classify(input) {
    "String" -> {
      let assert Ok(decoded) = decode.run(input, decode.string)
      int.parse(decoded)
      |> result.map(int.to_float)
      |> result.try_recover(fn(_) { float.parse(decoded) })
      |> result.map_error(fn(_) { error.NaNError })
    }
    "Float" -> {
      let assert Ok(decoded) = decode.run(input, decode.float)
      Ok(decoded)
    }
    "Int" -> {
      let assert Ok(decoded) = decode.run(input, decode.int)
      Ok(int.to_float(decoded))
    }

    t -> panic as { "Cannot convert type: " <> t }
  }
}

pub fn dynamic_to_bool(input: dynamic.Dynamic) {
  case dynamic.classify(input) {
    "Bool" -> {
      let assert Ok(decoded) = decode.run(input, decode.bool)
      Ok(decoded)
    }

    t -> panic as { "Cannot convert type: " <> t }
  }
}

pub fn comparison_reduce(
  values: List(dynamic.Dynamic),
  operator: fn(Float, Float) -> Bool,
) {
  use coerced_values <- result.try(list.try_map(values, dynamic_to_float))

  case coerced_values {
    [first, second] -> Ok(operator(first, second))
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
