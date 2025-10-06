import gleam/dynamic
import gleam/dynamic/decode
import gleam/float
import gleam/int
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
