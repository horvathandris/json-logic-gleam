import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/io
import gleam/json
import gleam/list
import gleam/result
import jsonlogic/rule.{
  type EvaluationError, type Rule, ArrayLiteral, BoolLiteral, CustomError,
  FloatLiteral, IntLiteral, Literal, NilLiteral, StringLiteral,
}

pub fn main() -> Nil {
  io.println("Hello from jsonlogic!")
}

pub fn apply(rule: Dynamic) -> Result(Dynamic, EvaluationError) {
  let assert Ok(typed_rule) = decode_rule(rule)
  do_apply(typed_rule)
}

fn decode_rule(rule: Dynamic) -> Result(Rule, List(decode.DecodeError)) {
  case dynamic.classify(rule) {
    "Bool" | "String" | "Int" | "Float" | "Nil" | "Array" | "List" ->
      Ok(Literal(decode_literal(rule)))
    x -> {
      echo x
      todo
    }
  }
}

fn decode_literal(literal: Dynamic) -> rule.JsonLiteral {
  let assert Ok(typed_literal) = case dynamic.classify(literal) {
    "Bool" ->
      decode.run(literal, decode.bool)
      |> result.map(BoolLiteral)
    "String" ->
      decode.run(literal, decode.string)
      |> result.map(StringLiteral)
    "Int" ->
      decode.run(literal, decode.int)
      |> result.map(IntLiteral)
    "Float" ->
      decode.run(literal, decode.float)
      |> result.map(FloatLiteral)
    "Nil" -> Ok(NilLiteral)
    "Array" | "List" -> {
      decode.run(literal, decode.list(decode.dynamic))
      |> result.map(list.map(_, decode_literal))
      |> result.map(ArrayLiteral)
    }
    _ -> todo
  }

  typed_literal
}

fn do_apply(rule: Rule) -> Result(Dynamic, EvaluationError) {
  case rule {
    Literal(literal) -> Ok(rule.evaluate_literal(literal))
    _ -> Error(CustomError("Unimplemented"))
  }
}
