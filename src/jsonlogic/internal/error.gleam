import gleam/dynamic/decode

pub type EvaluationError {
  UnknownOperatorError(String)
  InvalidRuleError(String)
  DecodeError(List(decode.DecodeError))
  NaNError
  InvalidArgumentsError
  CustomError(String)
}
