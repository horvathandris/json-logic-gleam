import gleam/bool
import gleam/dict
import gleam/dynamic
import gleam/dynamic/decode
import gleam/float
import gleam/int
import gleam/json
import gleam/list
import gleam/result
import gleam/string
import jsonlogic/internal/error
import jsonlogic/internal/operator
import jsonlogic/internal/rule

pub fn decode_rule_string(
  rule: String,
) -> Result(rule.Rule, error.EvaluationError) {
  json.parse(rule, using: decode.dynamic)
  |> result.map_error(error.JsonDecodeError)
  |> result.try(decode_rule)
}

pub fn decode_rule(
  rule: dynamic.Dynamic,
) -> Result(rule.Rule, error.EvaluationError) {
  case dynamic.classify(rule) {
    "Bool" | "String" | "Int" | "Float" | "Nil" | "Array" | "List" ->
      Ok(rule.Literal(decode_literal(rule)))
    "Dict" -> {
      let decoding_result =
        decode.run(rule, decode.dict(decode.string, decode.dynamic))
        |> result.map(dict.to_list)
        |> result.map_error(error.DecodeError)

      use decoded_entries <- result.try(decoding_result)
      let raw_rule =
        list.first(decoded_entries)
        |> result.map_error(fn(_) {
          error.InvalidRuleError("no operator in rule")
        })
        |> result.try(fn(rule) {
          decode_rule(rule.1)
          |> result.map(fn(values) {
            case values {
              rule.Literal(rule.ArrayLiteral(inner_values)) -> #(
                rule.0,
                inner_values,
              )
              other_rule -> #(rule.0, [other_rule])
            }
          })
        })

      use #(operator, values) <- result.try(raw_rule)
      use typed_operator <- result.map(decode_operator(operator))
      rule.Operation(typed_operator, values)
    }
    unrecognized -> panic as { "Unrecognized rule: " <> unrecognized }
  }
}

fn decode_literal(literal: dynamic.Dynamic) -> rule.JsonLiteral {
  let assert Ok(typed_literal) = case dynamic.classify(literal) {
    "Bool" ->
      decode.run(literal, decode.bool)
      |> result.map(rule.BoolLiteral)
    "String" ->
      decode.run(literal, decode.string)
      |> result.map(rule.StringLiteral)
    "Int" ->
      decode.run(literal, decode.int)
      |> result.map(rule.IntLiteral)
    "Float" ->
      decode.run(literal, decode.float)
      |> result.map(rule.FloatLiteral)
    "Nil" -> Ok(rule.NilLiteral)
    "Array" | "List" -> {
      decode.run(literal, decode.list(decode.dynamic))
      |> result.map(list.map(_, decode_literal))
      |> result.map(list.map(_, rule.Literal))
      |> result.map(rule.ArrayLiteral)
    }
    t -> panic as { "Unsupported literal type" <> t }
  }

  typed_literal
}

pub fn decode_operator(
  operator: String,
) -> Result(operator.Operator, error.EvaluationError) {
  case operator {
    "==" -> Ok(operator.AbstractEquals)
    "!=" -> Ok(operator.AbstractNotEquals)
    "===" -> Ok(operator.StrictEquals)
    "!==" -> Ok(operator.StrictNotEquals)
    ">" -> Ok(operator.GreaterThan)
    "<" -> Ok(operator.LessThan)
    ">=" -> Ok(operator.GreaterThanOrEqual)
    "<=" -> Ok(operator.LessThanOrEqual)
    "!" -> Ok(operator.Negate)
    "or" -> Ok(operator.Or)
    "and" -> Ok(operator.And)
    "?:" -> Ok(operator.Conditional)
    "in" -> Ok(operator.In)
    "cat" -> Ok(operator.Concatenate)
    _ -> Error(error.UnknownOperatorError(operator))
  }
}

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

pub fn dynamic_to_bool(
  input: dynamic.Dynamic,
) -> Result(#(Bool, dynamic.Dynamic), error.EvaluationError) {
  case dynamic.classify(input) {
    "Bool" -> {
      let assert Ok(decoded) = decode.run(input, decode.bool)
      Ok(#(decoded, input))
    }
    "Int" -> {
      let assert Ok(decoded) = decode.run(input, decode.int)
      Ok(#(decoded != 0, input))
    }

    t -> panic as { "Cannot convert type: " <> t }
  }
}

pub fn dynamic_to_string(
  input: dynamic.Dynamic,
) -> Result(String, error.EvaluationError) {
  decode.run(
    input,
    decode.one_of(decode.string, or: [
      decode.float |> decode.map(float.to_string),
      decode.int |> decode.map(int.to_string),
      decode.bool |> decode.map(bool.to_string) |> decode.map(string.lowercase),
    ]),
  )
  |> result.map_error(error.DecodeError)
}
