import gleam/dict
import gleam/dynamic
import gleam/dynamic/decode
import gleam/list
import gleam/result
import jsonlogic/evaluation
import jsonlogic/operator
import jsonlogic/rule

pub fn decode_rule(
  rule: dynamic.Dynamic,
) -> Result(rule.Rule, evaluation.EvaluationError) {
  case dynamic.classify(rule) {
    "Bool" | "String" | "Int" | "Float" | "Nil" | "Array" | "List" ->
      Ok(rule.Literal(decode_literal(rule)))
    "Dict" -> {
      let decoding_result =
        decode.run(rule, decode.dict(decode.string, decode.dynamic))
        |> result.map(dict.to_list)
        |> result.map_error(evaluation.DecodeError)

      use decoded_entries <- result.try(decoding_result)
      let raw_rule =
        list.first(decoded_entries)
        |> result.map_error(fn(_) {
          evaluation.InvalidRuleError("no operator in rule")
        })
        |> result.try(fn(rule) {
          decode.run(rule.1, decode.list(decode.dynamic))
          |> result.map_error(fn(_) {
            evaluation.InvalidRuleError("values are not a list")
          })
          |> result.map(fn(values) { #(rule.0, values) })
        })

      use #(operator, values) <- result.try(raw_rule)
      use typed_operator <- result.try(decode_operator(operator))
      use typed_values <- result.map(list.try_map(values, decode_rule))
      rule.Operation(typed_operator, typed_values)
    }
    x -> {
      echo x
      todo
    }
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
      |> result.map(rule.ArrayLiteral)
    }
    t -> panic as { "Unsupported literal type" <> t }
  }

  typed_literal
}

pub fn decode_operator(
  operator: String,
) -> Result(operator.Operator, evaluation.EvaluationError) {
  case operator {
    "===" -> Ok(operator.StrictEquals)
    _ -> Error(evaluation.UnknownOperatorError(operator))
  }
}
