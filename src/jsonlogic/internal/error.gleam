import gleam/dynamic/decode
import gleam/json

pub type EvaluationError {
  UnknownOperatorError(String)
  InvalidRuleError(String)
  DecodeError(List(decode.DecodeError))
  JsonDecodeError(json.DecodeError)
  NaNError
  InvalidArgumentsError
  CustomError(String)
}
