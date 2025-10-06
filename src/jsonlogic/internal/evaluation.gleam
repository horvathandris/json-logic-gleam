import gleam/bool
import gleam/dynamic
import gleam/list
import gleam/result
import jsonlogic/internal/error
import jsonlogic/internal/operator
import jsonlogic/internal/rule
import jsonlogic/internal/util

pub fn evaluate(
  rule: rule.Rule,
) -> Result(dynamic.Dynamic, error.EvaluationError) {
  case rule {
    rule.Literal(literal) -> Ok(evaluate_literal(literal))
    rule.Operation(operator, values) -> evaluate_operation(operator, values)
  }
}

pub fn evaluate_literal(literal: rule.JsonLiteral) -> dynamic.Dynamic {
  case literal {
    rule.BoolLiteral(value) -> dynamic.bool(value)
    rule.StringLiteral(value) -> dynamic.string(value)
    rule.IntLiteral(value) -> dynamic.int(value)
    rule.FloatLiteral(value) -> dynamic.float(value)
    rule.ArrayLiteral(value) ->
      list.map(value, evaluate_literal)
      |> dynamic.list
    rule.NilLiteral -> dynamic.nil()
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
  }
}

fn abstract_equals(values: List(rule.Rule)) {
  case values {
    [first, second] -> {
      use first <- result.try(evaluate(first))
      use second <- result.try(evaluate(second))
      use first <- result.try(util.dynamic_to_float(first))
      use second <- result.try(util.dynamic_to_float(second))
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
      use first <- result.try(util.dynamic_to_float(first))
      use second <- result.try(util.dynamic_to_float(second))
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
      use bool_value <- result.map(util.dynamic_to_bool(evaluated_value))
      bool.negate(bool_value)
    }
    _ -> Error(error.InvalidArgumentsError)
  }
}
