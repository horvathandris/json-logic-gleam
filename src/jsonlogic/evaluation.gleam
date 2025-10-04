import gleam/dynamic
import gleam/dynamic/decode
import gleam/list
import gleam/result
import jsonlogic/operator
import jsonlogic/rule

pub fn evaluate(rule: rule.Rule) -> Result(dynamic.Dynamic, EvaluationError) {
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
) -> Result(dynamic.Dynamic, EvaluationError) {
  case operator {
    operator.StrictEquals ->
      strict_equals(values)
      |> result.map(dynamic.bool)
    operator.StrictNotEquals ->
      strict_not_equals(values)
      |> result.map(dynamic.bool)
  }
}

fn strict_equals(values: List(rule.Rule)) {
  use evaluations <- result.map(list.try_map(values, evaluate))
  case evaluations {
    [] -> True
    [first, ..rest] -> list.all(rest, fn(evaluation) { first == evaluation })
  }
}

fn strict_not_equals(values: List(rule.Rule)) {
  use evaluations <- result.map(list.try_map(values, evaluate))
  case evaluations {
    [] -> True
    [first, ..rest] -> list.all(rest, fn(evaluation) { first == evaluation })
  }
}

pub type EvaluationError {
  UnknownOperatorError(String)
  InvalidRuleError(String)
  DecodeError(List(decode.DecodeError))
  NaNError
  InvalidArgumentsError
  CustomError(String)
}
