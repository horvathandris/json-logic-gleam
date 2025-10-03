import gleam/dynamic/decode
import gleam/json
import gleam/list
import gleam/result
import jsonlogic/operator
import jsonlogic/rule

pub fn evaluate(rule: rule.Rule) -> Result(json.Json, EvaluationError) {
  case rule {
    rule.Literal(literal) -> Ok(evaluate_literal(literal))
    rule.Operation(operator, values) -> evaluate_operation(operator, values)
  }
}

pub fn evaluate_literal(literal: rule.JsonLiteral) -> json.Json {
  case literal {
    rule.BoolLiteral(value) -> json.bool(value)
    rule.StringLiteral(value) -> json.string(value)
    rule.IntLiteral(value) -> json.int(value)
    rule.FloatLiteral(value) -> json.float(value)
    rule.ArrayLiteral(value) -> json.array(value, evaluate_literal)
    rule.NilLiteral -> json.null()
  }
}

pub fn evaluate_operation(
  operator: operator.Operator,
  values: List(rule.Rule),
) -> Result(json.Json, EvaluationError) {
  case operator {
    operator.StrictEquals ->
      strict_equals(values)
      |> result.map(json.bool)
  }
}

fn strict_equals(values: List(rule.Rule)) {
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
