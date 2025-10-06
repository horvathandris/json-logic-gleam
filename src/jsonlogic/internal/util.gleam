import gleam/dynamic
import gleam/list
import gleam/result
import jsonlogic/internal/decoding
import jsonlogic/internal/error

pub fn comparison_reduce(
  values: List(dynamic.Dynamic),
  operator: fn(Float, Float) -> Bool,
) {
  use coerced_values <- result.try(list.try_map(
    values,
    decoding.dynamic_to_float,
  ))

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
