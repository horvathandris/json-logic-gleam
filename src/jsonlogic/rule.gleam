import gleam/dynamic.{type Dynamic}
import gleam/list
import jsonlogic/operator.{type Operator}

pub type Rule {
  Literal(JsonLiteral)
  Operation(Operator, List(Rule))
}

pub type JsonLiteral {
  BoolLiteral(value: Bool)
  StringLiteral(value: String)
  IntLiteral(value: Int)
  FloatLiteral(value: Float)
  ArrayLiteral(value: List(JsonLiteral))
  NilLiteral
}

pub fn evaluate_literal(literal: JsonLiteral) -> Dynamic {
  case literal {
    BoolLiteral(value) -> dynamic.bool(value)
    StringLiteral(value) -> dynamic.string(value)
    IntLiteral(value) -> dynamic.int(value)
    FloatLiteral(value) -> dynamic.float(value)
    ArrayLiteral(value) ->
      list.map(value, evaluate_literal)
      |> dynamic.array
    NilLiteral -> dynamic.nil()
  }
}

pub type EvaluationError {
  NaNError
  InvalidArgumentsError
  CustomError(String)
}
