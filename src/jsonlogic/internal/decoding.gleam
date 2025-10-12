import gleam/bool
import gleam/dict
import gleam/dynamic
import gleam/dynamic/decode
import gleam/float
import gleam/int
import gleam/json
import gleam/list
import gleam/option
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
    "Bool" | "String" | "Int" | "Float" | "Nil" | "List" ->
      decode_literal(rule)
      |> result.map(rule.Literal)
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

fn decode_literal(
  literal: dynamic.Dynamic,
) -> Result(rule.JsonLiteral, error.EvaluationError) {
  case dynamic.classify(literal) {
    "Bool" -> {
      let assert Ok(decoded) = decode.run(literal, decode.bool)
      Ok(rule.BoolLiteral(decoded))
    }
    "String" -> {
      let assert Ok(decoded) = decode.run(literal, decode.string)
      Ok(rule.StringLiteral(decoded))
    }
    "Int" -> {
      let assert Ok(decoded) = decode.run(literal, decode.int)
      Ok(rule.IntLiteral(decoded))
    }
    "Float" -> {
      let assert Ok(decoded) = decode.run(literal, decode.float)
      Ok(rule.FloatLiteral(decoded))
    }
    "Nil" -> Ok(rule.NilLiteral)
    "List" -> {
      let assert Ok(decoded) = decode.run(literal, decode.list(decode.dynamic))
      list.try_map(decoded, decode_rule)
      |> result.map(rule.ArrayLiteral)
    }
    t -> panic as { "Unsupported literal type: " <> t }
  }
}

pub fn decode_operator(
  operator: String,
) -> Result(operator.Operator, error.EvaluationError) {
  case operator {
    "var" -> Ok(operator.Variable)
    "missing" -> Ok(operator.Missing)
    "missing_some" -> Ok(operator.MissingSome)
    "==" -> Ok(operator.AbstractEquals)
    "!=" -> Ok(operator.AbstractNotEquals)
    "===" -> Ok(operator.StrictEquals)
    "!==" -> Ok(operator.StrictNotEquals)
    ">" -> Ok(operator.GreaterThan)
    "<" -> Ok(operator.LessThan)
    ">=" -> Ok(operator.GreaterThanOrEqual)
    "<=" -> Ok(operator.LessThanOrEqual)
    "!" -> Ok(operator.Negate)
    "!!" -> Ok(operator.DoubleNegate)
    "or" -> Ok(operator.Or)
    "and" -> Ok(operator.And)
    "?:" -> Ok(operator.Conditional)
    "in" -> Ok(operator.In)
    "cat" -> Ok(operator.Concatenate)
    "%" -> Ok(operator.Modulo)
    "max" -> Ok(operator.Max)
    "min" -> Ok(operator.Min)
    "+" -> Ok(operator.Plus)
    "*" -> Ok(operator.Multiply)
    "-" -> Ok(operator.Minus)
    "/" -> Ok(operator.Divide)
    "substr" -> Ok(operator.Substring)
    "merge" -> Ok(operator.Merge)
    "if" -> Ok(operator.If)
    "filter" -> Ok(operator.Filter)
    "map" -> Ok(operator.Map)
    _ -> Error(error.UnknownOperatorError(operator))
  }
}

pub fn dynamic_to_int(
  input: dynamic.Dynamic,
) -> Result(Int, error.EvaluationError) {
  case dynamic.classify(input) {
    "String" -> {
      let assert Ok(decoded) = decode.run(input, decode.string)
      case decoded {
        "" -> Ok(0)
        _ ->
          float.parse(decoded)
          |> result.map(float.truncate)
          |> result.try_recover(fn(_) { int.parse(decoded) })
          |> result.map_error(fn(_) { error.NaNError })
      }
    }
    "Int" -> {
      let assert Ok(decoded) = decode.run(input, decode.int)
      Ok(decoded)
    }
    "Float" -> {
      let assert Ok(decoded) = decode.run(input, decode.float)
      Ok(float.truncate(decoded))
    }
    "Bool" -> {
      let assert Ok(decoded) = decode.run(input, decode.bool)
      bool_to_float(decoded)
      |> float.truncate
      |> Ok
    }
    t -> panic as { "Cannot convert type: " <> t }
  }
}

pub fn dynamic_to_float(
  input: dynamic.Dynamic,
) -> Result(Float, error.EvaluationError) {
  case dynamic.classify(input) {
    "String" -> {
      let assert Ok(decoded) = decode.run(input, decode.string)
      case decoded {
        "" -> Ok(0.0)
        _ ->
          int.parse(decoded)
          |> result.map(int.to_float)
          |> result.try_recover(fn(_) { float.parse(decoded) })
          |> result.map_error(fn(_) { error.NaNError })
      }
    }
    "Float" -> {
      let assert Ok(decoded) = decode.run(input, decode.float)
      Ok(decoded)
    }
    "Int" -> {
      let assert Ok(decoded) = decode.run(input, decode.int)
      Ok(int.to_float(decoded))
    }
    "Bool" -> {
      let assert Ok(decoded) = decode.run(input, decode.bool)
      bool_to_float(decoded)
      |> Ok
    }
    "Nil" -> Ok(0.0)

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
    "Float" -> {
      let assert Ok(decoded) = decode.run(input, decode.float)
      Ok(#(decoded != 0.0, input))
    }
    "String" -> {
      let assert Ok(decoded) = decode.run(input, decode.string)
      Ok(#(decoded != "", input))
    }
    "List" -> {
      let assert Ok(decoded) = decode.run(input, decode.list(decode.dynamic))
      Ok(#(decoded != [], input))
    }
    "Nil" -> Ok(#(False, input))

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

pub fn dynamic_to_array(
  input: dynamic.Dynamic,
) -> Result(List(dynamic.Dynamic), error.EvaluationError) {
  decode.run(
    input,
    decode.one_of(
      decode.optional(decode.list(decode.dynamic))
        |> decode.map(fn(value) {
          case value {
            option.None -> []
            option.Some(value) -> value
          }
        }),
      or: [
        decode.dynamic |> decode.map(list.wrap),
      ],
    ),
  )
  |> result.map_error(error.DecodeError)
}

pub fn coerce_types(
  first: dynamic.Dynamic,
  second: dynamic.Dynamic,
) -> Result(#(dynamic.Dynamic, dynamic.Dynamic), error.EvaluationError) {
  case dynamic.classify(first), dynamic.classify(second) {
    x, y if x == y -> Ok(#(first, second))

    "Bool", _ -> {
      let assert Ok(first) = decode.run(first, decode.bool)
      bool_to_float(first)
      |> dynamic.float
      |> coerce_types(second)
    }
    _, "Bool" -> {
      let assert Ok(second) = decode.run(second, decode.bool)
      bool_to_float(second)
      |> dynamic.float
      |> coerce_types(first)
    }
    "Int", "String" | "Float", "String" | "String", "Float" | "String", "Int" -> {
      use first <- result.try(dynamic_to_float(first))
      use second <- result.map(dynamic_to_float(second))
      #(dynamic.float(first), dynamic.float(second))
    }
    a, b -> panic as { "Unsupported types: " <> a <> " and " <> b }
  }
}

fn bool_to_float(value: Bool) -> Float {
  case value {
    True -> 1.0
    False -> 0.0
  }
}

pub fn decode_data(
  key: dynamic.Dynamic,
  data: dynamic.Dynamic,
  or default: option.Option(dynamic.Dynamic),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  case
    key == dynamic.nil(),
    key == dynamic.string(""),
    key == dynamic.list([])
  {
    True, _, _ | _, True, _ | _, _, True -> Ok(data)
    _, _, _ -> do_decode_data(key, data, default)
  }
}

fn do_decode_data(
  key: dynamic.Dynamic,
  data: dynamic.Dynamic,
  or default: option.Option(dynamic.Dynamic),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use key <- result.map(dynamic_to_string(key))
  let keys = string.split(key, on: ".")
  decode.run(data, decode.at(keys, decode.dynamic))
  |> result.try_recover(fn(e) {
    let indices =
      list.try_map(keys, int.parse)
      |> result.replace_error(e)
    use indices <- result.try(indices)
    decode.run(data, decode.at(indices, decode.dynamic))
    |> result.replace_error(e)
  })
  |> result.lazy_unwrap(fn() {
    case default {
      option.Some(default) -> default
      option.None -> dynamic.nil()
    }
  })
}
