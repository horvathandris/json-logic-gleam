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
