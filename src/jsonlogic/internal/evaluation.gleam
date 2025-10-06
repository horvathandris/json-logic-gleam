import gleam/bool
import gleam/dynamic
import gleam/list
import gleam/result
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
  util.comparison_reduce(evaluated_values, fn(a, b) { a >. b })
}

fn less_than(values: List(rule.Rule)) -> Result(Bool, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  util.comparison_reduce(evaluated_values, fn(a, b) { a <. b })
}

fn greater_than_or_equal(
  values: List(rule.Rule),
) -> Result(Bool, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  util.comparison_reduce(evaluated_values, fn(a, b) { a >=. b })
}

fn less_than_or_equal(
  values: List(rule.Rule),
) -> Result(Bool, error.EvaluationError) {
  use evaluated_values <- result.try(list.try_map(values, evaluate))
  util.comparison_reduce(evaluated_values, fn(a, b) { a <=. b })
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

pub fn conditional(
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
