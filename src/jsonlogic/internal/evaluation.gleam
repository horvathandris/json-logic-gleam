import gleam/bool
import gleam/dynamic
import gleam/dynamic/decode
import gleam/float
import gleam/list
import gleam/result
import gleam/string
import jsonlogic/internal/decoding
import jsonlogic/internal/error
import jsonlogic/internal/operator
import jsonlogic/internal/rule
import jsonlogic/internal/util

pub fn evaluate(
  rule: rule.Rule,
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  case rule {
    rule.Literal(literal) -> evaluate_literal(literal)
    rule.Operation(operator, values) -> evaluate_operation(operator, values)
  }
}

pub fn evaluate_literal(
  literal: rule.JsonLiteral,
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  case literal {
    rule.BoolLiteral(value) -> Ok(dynamic.bool(value))
    rule.StringLiteral(value) -> Ok(dynamic.string(value))
    rule.IntLiteral(value) -> Ok(dynamic.int(value))
    rule.FloatLiteral(value) -> Ok(dynamic.float(value))
    rule.ArrayLiteral(values) ->
      list.try_map(values, evaluate)
      |> result.map(dynamic.list)
    rule.NilLiteral -> Ok(dynamic.nil())
  }
}

pub fn evaluate_operation(
  operator: operator.Operator,
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  case operator {
    operator.AbstractEquals ->
      abstract_equals(values)
      |> result.map(dynamic.bool)
    operator.AbstractNotEquals ->
      abstract_not_equals(values)
      |> result.map(dynamic.bool)
    operator.StrictEquals ->
      strict_equals(values)
      |> result.map(dynamic.bool)
    operator.StrictNotEquals ->
      strict_not_equals(values)
      |> result.map(dynamic.bool)
    operator.GreaterThan ->
      greater_than(values)
      |> result.map(dynamic.bool)
    operator.LessThan ->
      less_than(values)
      |> result.map(dynamic.bool)
    operator.GreaterThanOrEqual ->
      greater_than_or_equal(values)
      |> result.map(dynamic.bool)
    operator.LessThanOrEqual ->
      less_than_or_equal(values)
      |> result.map(dynamic.bool)
    operator.Negate ->
      negate(values)
      |> result.map(dynamic.bool)
    operator.Or -> or(values)
    operator.And -> and(values)
    operator.Conditional -> conditional(values)
    operator.In -> in(values)
    operator.Concatenate -> concatenate(values)
    operator.Modulo -> modulo(values)
    operator.Max -> max(values)
    operator.Min -> min(values)
    operator.Plus -> plus(values)
    operator.Multiply -> multiply(values)
    operator.Minus -> minus(values)
    operator.Divide -> divide(values)
    operator.Substring -> substring(values)
    operator.Merge -> merge(values)
  }
}

fn abstract_equals(values: List(rule.Rule)) {
  case values {
    [first, second] -> {
      use first <- result.try(evaluate(first))
      use second <- result.try(evaluate(second))
      use first <- result.try(decoding.dynamic_to_float(first))
      use second <- result.try(decoding.dynamic_to_float(second))
      Ok(first == second)
    }
    _ -> Error(error.InvalidArgumentsError)
  }
}

fn abstract_not_equals(values: List(rule.Rule)) {
  case values {
    [first, second] -> {
      use first <- result.try(evaluate(first))
      use second <- result.try(evaluate(second))
      use first <- result.try(decoding.dynamic_to_float(first))
      use second <- result.try(decoding.dynamic_to_float(second))
      Ok(first != second)
    }
    _ -> Error(error.InvalidArgumentsError)
  }
}

fn strict_equals(values: List(rule.Rule)) {
  case values {
    [first, second] -> {
      use first <- result.try(evaluate(first))
      use second <- result.try(evaluate(second))
      Ok(first == second)
    }
    _ -> Error(error.InvalidArgumentsError)
  }
}

fn strict_not_equals(
  values: List(rule.Rule),
) -> Result(Bool, error.EvaluationError) {
  case values {
    [first, second] -> {
      use first <- result.try(evaluate(first))
      use second <- result.try(evaluate(second))
      Ok(first != second)
    }
    _ -> Error(error.InvalidArgumentsError)
  }
}

fn greater_than(values: List(rule.Rule)) -> Result(Bool, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  util.comparison_reduce(float_values, fn(a, b) { a >. b })
}

fn less_than(values: List(rule.Rule)) -> Result(Bool, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  util.comparison_reduce(float_values, fn(a, b) { a <. b })
}

fn greater_than_or_equal(
  values: List(rule.Rule),
) -> Result(Bool, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  util.comparison_reduce(float_values, fn(a, b) { a >=. b })
}

fn less_than_or_equal(
  values: List(rule.Rule),
) -> Result(Bool, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  util.comparison_reduce(float_values, fn(a, b) { a <=. b })
}

fn negate(values: List(rule.Rule)) -> Result(Bool, error.EvaluationError) {
  case values {
    [value] -> {
      use evaluated_value <- result.try(evaluate(value))
      use #(bool_value, _) <- result.map(decoding.dynamic_to_bool(
        evaluated_value,
      ))
      bool.negate(bool_value)
    }
    _ -> Error(error.InvalidArgumentsError)
  }
}

fn or(values: List(rule.Rule)) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use bool_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_bool,
  ))
  list.find_map(bool_values, fn(value) {
    case value.0 {
      True -> Ok(value.1)
      False -> Error(Nil)
    }
  })
  |> result.unwrap(dynamic.bool(False))
  |> Ok
}

fn and(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use bool_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_bool,
  ))
  case list.all(bool_values, fn(value) { value.0 }) {
    True ->
      list.last(bool_values)
      |> result.map(fn(value) { value.1 })
      // empty list case
      |> result.unwrap(dynamic.bool(True))
      |> Ok
    False -> Ok(dynamic.bool(False))
  }
}

fn conditional(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use bool_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_bool,
  ))
  case bool_values {
    [#(True, first), _] -> Ok(first)
    [#(False, _), #(_, second)] -> Ok(second)
    [#(True, _), #(_, second), _] -> Ok(second)
    [#(False, _), _, #(_, third)] -> Ok(third)
    _ -> Error(error.InvalidArgumentsError)
  }
}

fn in(values: List(rule.Rule)) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  case evaluated_values {
    [] | [_] -> Ok(dynamic.bool(False))
    [first, second] ->
      case dynamic.classify(first), dynamic.classify(second) {
        "String", "String" -> {
          let assert Ok(first) = decode.run(first, decode.string)
          let assert Ok(second) = decode.run(second, decode.string)
          string.contains(does: second, contain: first)
          |> dynamic.bool
          |> Ok
        }
        "String", "Array" | "String", "List" -> {
          let assert Ok(first) = decode.run(first, decode.string)
          // todo: make this safer
          let assert Ok(second) = decode.run(second, decode.list(decode.string))
          list.contains(second, any: first)
          |> dynamic.bool
          |> Ok
        }
        _, _ -> Error(error.InvalidArgumentsError)
      }
    _ -> Error(error.InvalidArgumentsError)
  }
}

fn concatenate(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use string_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_string,
  ))
  string.join(string_values, with: "")
  |> dynamic.string
  |> Ok
}

fn modulo(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  case list.length(float_values) > 1 {
    True ->
      util.chain_reduce_result(float_values, util.modulo)
      |> result.map(util.float_to_dynamic)
    False -> Error(error.InvalidArgumentsError)
  }
}

fn max(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  case float_values {
    [first] -> Ok(util.float_to_dynamic(first))
    [_, ..] ->
      util.chain_reduce(float_values, float.max)
      |> result.map(util.float_to_dynamic)
    _ -> Error(error.InvalidArgumentsError)
  }
}

fn min(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  case float_values {
    [first] -> Ok(util.float_to_dynamic(first))
    [_, ..] ->
      util.chain_reduce(float_values, float.min)
      |> result.map(util.float_to_dynamic)
    _ -> Error(error.InvalidArgumentsError)
  }
}

fn plus(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  case float_values {
    [] -> Ok(dynamic.int(0))
    [_, ..] ->
      float.sum(float_values)
      |> util.float_to_dynamic
      |> Ok
  }
}

fn multiply(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  case float_values {
    [] -> Ok(dynamic.int(1))
    [_, ..] ->
      float.product(float_values)
      |> util.float_to_dynamic
      |> Ok
  }
}

fn minus(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  case float_values {
    [] -> Ok(dynamic.int(0))
    [first] ->
      float.negate(first)
      |> util.float_to_dynamic
      |> Ok
    [_, ..] ->
      util.chain_reduce(float_values, float.subtract)
      |> result.map(util.float_to_dynamic)
  }
}

fn divide(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use float_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_float,
  ))
  case float_values {
    [] -> Ok(dynamic.int(1))
    [_, ..] ->
      util.chain_reduce_result(float_values, util.divide)
      |> result.map(util.float_to_dynamic)
  }
}

fn substring(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  case evaluated_values {
    [first] ->
      decoding.dynamic_to_string(first)
      |> result.map(dynamic.string)
    [first, second] -> {
      use second <- result.try(decoding.dynamic_to_int(second))
      use first <- result.map(decoding.dynamic_to_string(first))
      case second < 0 {
        True -> string.length(first) + second
        False -> second
      }
      |> string.drop_start(first, _)
      |> dynamic.string
    }
    [first, second, third] -> {
      use third <- result.try(decoding.dynamic_to_int(third))
      use second <- result.try(decoding.dynamic_to_int(second))
      use first <- result.map(decoding.dynamic_to_string(first))
      let left_trimmed =
        case second < 0 {
          True -> string.length(first) + second
          False -> second
        }
        |> string.drop_start(first, _)

      case third < 0 {
        True -> -third
        False -> string.length(left_trimmed) - third
      }
      |> string.drop_end(left_trimmed, _)
      |> dynamic.string
    }

    _ -> Error(error.InvalidArgumentsError)
  }
}

fn merge(
  values: List(rule.Rule),
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  use array_values <- result.try(list.try_map(
    evaluated_values,
    decoding.dynamic_to_array,
  ))
  case array_values {
    [] -> Ok(dynamic.array([]))
    _ ->
      list.flatten(array_values)
      |> dynamic.array
      |> Ok
  }
}
