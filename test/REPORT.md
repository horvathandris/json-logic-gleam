# ./suites/string/cat.json — 9/9 passed

| Test | Result |
|------|--------|
| Cat with single string argument | ✅ |
| Cat with array of single string | ✅ |
| Cat with two strings | ✅ |
| Cat with numbers | ✅ |
| Cat with mixed types | ✅ |
| Cat with multiple arguments | ✅ |
| Cat with no arguments returns empty string | ✅ |
| Cat with null values | ✅ |
| Cat with boolean values | ✅ |

# ./suites/iterators.extra.json — 10/34 passed

| Test | Result |
|------|--------|
| if with dynamic arguments throws | ❌ |
| or with dynamic arguments throws | ❌ |
| and with dynamic arguments throws | ❌ |
| map with dynamic arguments throws | ❌ |
| filter with dynamic arguments throws | ❌ |
| reduce with dynamic arguments throws | ❌ |
| some with dynamic arguments throws | ❌ |
| all with dynamic arguments throws | ❌ |
| none with dynamic arguments throws | ❌ |
| < with dynamic arguments throws | ❌ |
| <= with dynamic arguments throws | ❌ |
| > with dynamic arguments throws | ❌ |
| >= with dynamic arguments throws | ❌ |
| == with dynamic arguments throws | ❌ |
| != with dynamic arguments throws | ❌ |
| === with dynamic arguments throws | ❌ |
| !== with dynamic arguments throws | ❌ |
| if with static non-array argument throws | ❌ |
| or with static non-array argument throws | ❌ |
| and with static non-array argument throws | ❌ |
| map with static non-array argument throws | ✅ |
| filter with static non-array argument throws | ✅ |
| reduce with static non-array argument throws | ✅ |
| some with static non-array argument throws | ✅ |
| all with static non-array argument throws | ✅ |
| none with static non-array argument throws | ✅ |
| < with static non-array argument throws | ❌ |
| <= with static non-array argument throws | ❌ |
| > with static non-array argument throws | ❌ |
| >= with static non-array argument throws | ❌ |
| == with static non-array argument throws | ✅ |
| != with static non-array argument throws | ✅ |
| === with static non-array argument throws | ✅ |
| !== with static non-array argument throws | ✅ |

# ./suites/array/all.json — 10/12 passed

| Test | Result |
|------|--------|
| All elements are positive | ✅ |
| Not all elements are positive | ✅ |
| All objects meet age requirement | ✅ |
| Not all objects meet criteria | ✅ |
| Empty array returns false | ✅ |
| Null array should throw | ❌ |
| Missing array returns error | ❌ |
| Null predicate returns false | ✅ |
| All with compound conditions | ✅ |
| All with nested array operations | ✅ |
| All with mixed types coercion to boolean | ✅ |
| All with string comparison | ✅ |

# ./suites/arithmetic/plus.json — 30/32 passed

| Test | Result |
|------|--------|
| Addition | ✅ |
| Addition (2) | ✅ |
| Addition with Multiple Operands | ✅ |
| Addition with Negative Numbers | ✅ |
| Addition with Strings | ✅ |
| Addition with Booleans | ✅ |
| Addition with Multiple Value Types | ✅ |
| Plus Operator with Single Operand (Number) | ✅ |
| Plus Operator with Single Operand (Negative Number) | ✅ |
| Plus Operator with zero operands is zero | ✅ |
| Plus Operator with Single Operand, Direct (Number) | ✅ |
| Plus Operator with Single Operand, Direct (0) | ✅ |
| Plus Operator with Single Operand (String) | ✅ |
| Plus Operator with Single Operand, Direct (Negative Number String) | ✅ |
| Plus Operator with Single Operand, Direct (String Decimal) | ✅ |
| Plus Operator with Single Operand, Direct (String Negative Decimal) | ✅ |
| Plus Operator with Single Operand, Direct (String 0.5) | ✅ |
| Plus Operator with Single Operand, Direct (String 1e2) | ✅ |
| Plus Operator with Single Operand, Direct (String 0) | ✅ |
| Plus Operator with Single Operand, Direct (true) | ✅ |
| Plus Operator with Single Operand, Direct (false) | ✅ |
| Plus Operator with Single Operand, Direct (Empty String) | ✅ |
| Plus Operator with a Single Operand, Direct (null) | ✅ |
| Addition with val | ✅ |
| Addition with string produces NaN | ✅ |
| Addition with Array produces NaN | ✅ |
| Addition with Array from context produces NaN | ✅ |
| Addition with Object produces NaN | ✅ |
| Plus Operator with Single Operand, Invalid String Produces NaN | ✅ |
| Plus Operator with Single Operand, Array Input Produces NaN | ✅ |
| Plus Operator with Single Operand, Object Input Produces NaN | ❌ |
| Plus Operator with Single Operand, Direct Object Input Produces NaN | ❌ |

# ./suites/truthiness.json — 12/13 passed

| Test | Result |
|------|--------|
| Truthy: true | ✅ |
| Falsey: false | ✅ |
| Truthy: 1 | ✅ |
| Falsey: 0 | ✅ |
| Truthy: -1 | ✅ |
| Falsey: [] | ✅ |
| Truthy: {} | ❌ |
| Falsey: '' | ✅ |
| Falsey: null | ✅ |
| Truthy: Zero Key Object | ✅ |
| Truthy: Single Key Object | ✅ |
| Truthy: Multi Key Object | ✅ |
| Truthy: Single Key Object (Empty Key) | ✅ |

# ./suites/compatible.json — 278/278 passed

| Test | Result |
|------|--------|
| true | ✅ |
| false | ✅ |
| 17 | ✅ |
| 3.14 | ✅ |
| "apple" | ✅ |
| null | ✅ |
| ["a","b"] | ✅ |
| {"==":[1,1]} | ✅ |
| {"==":[1,"1"]} | ✅ |
| {"==":[1,2]} | ✅ |
| {"===":[1,1]} | ✅ |
| {"===":[1,"1"]} | ✅ |
| {"===":[1,2]} | ✅ |
| {"!=":[1,2]} | ✅ |
| {"!=":[1,1]} | ✅ |
| {"!=":[1,"1"]} | ✅ |
| {"!==":[1,2]} | ✅ |
| {"!==":[1,1]} | ✅ |
| {"!==":[1,"1"]} | ✅ |
| {">":[2,1]} | ✅ |
| {">":[1,1]} | ✅ |
| {">":[1,2]} | ✅ |
| {">":["2",1]} | ✅ |
| {">=":[2,1]} | ✅ |
| {">=":[1,1]} | ✅ |
| {">=":[1,2]} | ✅ |
| {">=":["2",1]} | ✅ |
| {"<":[2,1]} | ✅ |
| {"<":[1,1]} | ✅ |
| {"<":[1,2]} | ✅ |
| {"<":["1",2]} | ✅ |
| {"<":[1,2,3]} | ✅ |
| {"<":[1,1,3]} | ✅ |
| {"<":[1,4,3]} | ✅ |
| {"<=":[2,1]} | ✅ |
| {"<=":[1,1]} | ✅ |
| {"<=":[1,2]} | ✅ |
| {"<=":["1",2]} | ✅ |
| {"<=":[1,2,3]} | ✅ |
| {"<=":[1,4,3]} | ✅ |
| {"!":[false]} | ✅ |
| {"!":false} | ✅ |
| {"!":[true]} | ✅ |
| {"!":true} | ✅ |
| {"!":0} | ✅ |
| {"!":1} | ✅ |
| {"or":[true,true]} | ✅ |
| {"or":[false,true]} | ✅ |
| {"or":[true,false]} | ✅ |
| {"or":[false,false]} | ✅ |
| {"or":[false,false,true]} | ✅ |
| {"or":[false,false,false]} | ✅ |
| {"or":[false]} | ✅ |
| {"or":[true]} | ✅ |
| {"or":[1,3]} | ✅ |
| {"or":[3,false]} | ✅ |
| {"or":[false,3]} | ✅ |
| {"and":[true,true]} | ✅ |
| {"and":[false,true]} | ✅ |
| {"and":[true,false]} | ✅ |
| {"and":[false,false]} | ✅ |
| {"and":[true,true,true]} | ✅ |
| {"and":[true,true,false]} | ✅ |
| {"and":[false]} | ✅ |
| {"and":[true]} | ✅ |
| {"and":[1,3]} | ✅ |
| {"and":[3,false]} | ✅ |
| {"and":[false,3]} | ✅ |
| {"?:":[true,1,2]} | ✅ |
| {"?:":[false,1,2]} | ✅ |
| {"in":["Bart",["Bart","Homer","Lisa","Marge","Maggie"]]} | ✅ |
| {"in":["Milhouse",["Bart","Homer","Lisa","Marge","Maggie"]]} | ✅ |
| {"in":["Spring","Springfield"]} | ✅ |
| {"in":["i","team"]} | ✅ |
| {"cat":"ice"} | ✅ |
| {"cat":["ice"]} | ✅ |
| {"cat":["ice","cream"]} | ✅ |
| {"cat":[1,2]} | ✅ |
| {"cat":["Robocop",2]} | ✅ |
| {"cat":["we all scream for ","ice","cream"]} | ✅ |
| {"%":[1,2]} | ✅ |
| {"%":[2,2]} | ✅ |
| {"%":[3,2]} | ✅ |
| {"max":[1,2,3]} | ✅ |
| {"max":[1,3,3]} | ✅ |
| {"max":[3,2,1]} | ✅ |
| {"max":[1]} | ✅ |
| {"min":[1,2,3]} | ✅ |
| {"min":[1,1,3]} | ✅ |
| {"min":[3,2,1]} | ✅ |
| {"min":[1]} | ✅ |
| {"+":[1,2]} | ✅ |
| {"+":[2,2,2]} | ✅ |
| {"+":[1]} | ✅ |
| {"+":["1",1]} | ✅ |
| {"*":[3,2]} | ✅ |
| {"*":[2,2,2]} | ✅ |
| {"*":[1]} | ✅ |
| {"*":["1",1]} | ✅ |
| {"-":[2,3]} | ✅ |
| {"-":[3,2]} | ✅ |
| {"-":[3]} | ✅ |
| {"-":["1",1]} | ✅ |
| {"/":[4,2]} | ✅ |
| {"/":[2,4]} | ✅ |
| {"/":["1",1]} | ✅ |
| {"substr":["jsonlogic",4]} | ✅ |
| {"substr":["jsonlogic",-5]} | ✅ |
| {"substr":["jsonlogic",0,1]} | ✅ |
| {"substr":["jsonlogic",-1,1]} | ✅ |
| {"substr":["jsonlogic",4,5]} | ✅ |
| {"substr":["jsonlogic",-5,5]} | ✅ |
| {"substr":["jsonlogic",-5,-2]} | ✅ |
| {"substr":["jsonlogic",1,-5]} | ✅ |
| {"merge":[]} | ✅ |
| {"merge":[[1]]} | ✅ |
| {"merge":[[1],[]]} | ✅ |
| {"merge":[[1],[2]]} | ✅ |
| {"merge":[[1],[2],[3]]} | ✅ |
| {"merge":[[1,2],[3]]} | ✅ |
| {"merge":[[1],[2,3]]} | ✅ |
| {"merge":1} | ✅ |
| {"merge":[1,2]} | ✅ |
| {"merge":[1,[2]]} | ✅ |
| {"if":[]} | ✅ |
| {"if":[true]} | ✅ |
| {"if":[false]} | ✅ |
| {"if":["apple"]} | ✅ |
| {"if":[true,"apple"]} | ✅ |
| {"if":[false,"apple"]} | ✅ |
| {"if":[true,"apple","banana"]} | ✅ |
| {"if":[false,"apple","banana"]} | ✅ |
| {"if":[[],"apple","banana"]} | ✅ |
| {"if":[[1],"apple","banana"]} | ✅ |
| {"if":[[1,2,3,4],"apple","banana"]} | ✅ |
| {"if":["","apple","banana"]} | ✅ |
| {"if":["zucchini","apple","banana"]} | ✅ |
| {"if":["0","apple","banana"]} | ✅ |
| {"===":[0,"0"]} | ✅ |
| {"===":[0,{"+":"0"}]} | ✅ |
| {"if":[{"+":"0"},"apple","banana"]} | ✅ |
| {"if":[{"+":"1"},"apple","banana"]} | ✅ |
| {"if":[0,"apple","banana"]} | ✅ |
| {"if":[1,"apple","banana"]} | ✅ |
| {"if":[3.1416,"apple","banana"]} | ✅ |
| {"if":[-1,"apple","banana"]} | ✅ |
| {"!":[[]]} | ✅ |
| {"!!":[[]]} | ✅ |
| {"and":[[],true]} | ✅ |
| {"or":[[],true]} | ✅ |
| {"!":[0]} | ✅ |
| {"!!":[0]} | ✅ |
| {"and":[0,true]} | ✅ |
| {"or":[0,true]} | ✅ |
| {"!":[""]} | ✅ |
| {"!!":[""]} | ✅ |
| {"and":["",true]} | ✅ |
| {"or":["",true]} | ✅ |
| {"!":["0"]} | ✅ |
| {"!!":["0"]} | ✅ |
| {"and":["0",true]} | ✅ |
| {"or":["0",true]} | ✅ |
| {"if":[{">":[2,1]},"apple","banana"]} | ✅ |
| {"if":[{">":[1,2]},"apple","banana"]} | ✅ |
| {"if":[true,{"cat":["ap","ple"]},{"cat":["ba","na","na"]}]} | ✅ |
| {"if":[false,{"cat":["ap","ple"]},{"cat":["ba","na","na"]}]} | ✅ |
| {"if":[true,"apple",true,"banana"]} | ✅ |
| {"if":[true,"apple",false,"banana"]} | ✅ |
| {"if":[false,"apple",true,"banana"]} | ✅ |
| {"if":[false,"apple",false,"banana"]} | ✅ |
| {"if":[true,"apple",true,"banana","carrot"]} | ✅ |
| {"if":[true,"apple",false,"banana","carrot"]} | ✅ |
| {"if":[false,"apple",true,"banana","carrot"]} | ✅ |
| {"if":[false,"apple",false,"banana","carrot"]} | ✅ |
| {"if":[false,"apple",false,"banana",false,"carrot"]} | ✅ |
| {"if":[false,"apple",false,"banana",false,"carrot","date"]} | ✅ |
| {"if":[false,"apple",false,"banana",true,"carrot","date"]} | ✅ |
| {"if":[false,"apple",true,"banana",false,"carrot","date"]} | ✅ |
| {"if":[false,"apple",true,"banana",true,"carrot","date"]} | ✅ |
| {"if":[true,"apple",false,"banana",false,"carrot","date"]} | ✅ |
| {"if":[true,"apple",false,"banana",true,"carrot","date"]} | ✅ |
| {"if":[true,"apple",true,"banana",false,"carrot","date"]} | ✅ |
| {"if":[true,"apple",true,"banana",true,"carrot","date"]} | ✅ |
| [1,{"var":"x"},3] | ✅ |
| {"if":[{"var":"x"},[{"var":"y"}],99]} | ✅ |
| {"and":[{">":[3,1]},true]} | ✅ |
| {"and":[{">":[3,1]},false]} | ✅ |
| {"and":[{">":[3,1]},{"!":true}]} | ✅ |
| {"and":[{">":[3,1]},{"<":[1,3]}]} | ✅ |
| {"?:":[{">":[3,1]},"visible","hidden"]} | ✅ |
| {"var":["a"]} | ✅ |
| {"var":["b"]} | ✅ |
| {"var":["a"]} | ✅ |
| {"var":"a"} | ✅ |
| {"var":"b"} | ✅ |
| {"var":"a"} | ✅ |
| {"var":["a",1]} | ✅ |
| {"var":["b",2]} | ✅ |
| {"var":"a.b"} | ✅ |
| {"var":"a.q"} | ✅ |
| {"var":["a.q",9]} | ✅ |
| {"var":1} | ✅ |
| {"var":"1"} | ✅ |
| {"var":"1.1"} | ✅ |
| {"and":[{"<":[{"var":"temp"},110]},{"==":[{"var":"pie.filling"},"apple"]}]} | ✅ |
| {"var":[{"?:":[{"<":[{"var":"temp"},110]},"pie.filling","pie.eta"]}]} | ✅ |
| {"in":[{"var":"filling"},["apple","cherry"]]} | ✅ |
| {"var":"a.b.c"} | ✅ |
| {"var":"a.b.c"} | ✅ |
| {"var":"a.b.c"} | ✅ |
| {"var":""} | ✅ |
| {"var":null} | ✅ |
| {"var":[]} | ✅ |
| {"missing":[]} | ✅ |
| {"missing":["a"]} | ✅ |
| {"missing":"a"} | ✅ |
| {"missing":"a"} | ✅ |
| {"missing":["a"]} | ✅ |
| {"missing":["a","b"]} | ✅ |
| {"missing":["a","b"]} | ✅ |
| {"missing":["a","b"]} | ✅ |
| {"missing":["a","b"]} | ✅ |
| {"missing":["a","b"]} | ✅ |
| {"missing":["a.b"]} | ✅ |
| {"missing":["a.b"]} | ✅ |
| {"missing":["a.b"]} | ✅ |
| {"missing":["a.b"]} | ✅ |
| {"missing":["a.b","a.c"]} | ✅ |
| {"missing_some":[1,["a","b"]]} | ✅ |
| {"missing_some":[1,["a","b"]]} | ✅ |
| {"missing_some":[1,["a","b"]]} | ✅ |
| {"missing_some":[1,["a","b"]]} | ✅ |
| {"missing_some":[2,["a","b","c"]]} | ✅ |
| {"missing_some":[2,["a","b","c"]]} | ✅ |
| {"missing_some":[2,["a","b","c"]]} | ✅ |
| {"missing_some":[2,["a","b","c"]]} | ✅ |
| {"missing_some":[2,["a","b","c"]]} | ✅ |
| {"if":[{"missing":"a"},"missed it","found it"]} | ✅ |
| {"if":[{"missing":"a"},"missed it","found it"]} | ✅ |
| {"missing":{"merge":["vin",{"if":[{"var":"financing"},["apr"],[]]}]}} | ✅ |
| {"missing":{"merge":["vin",{"if":[{"var":"financing"},["apr"],[]]}]}} | ✅ |
| {"filter":[{"var":"integers"},true]} | ✅ |
| {"filter":[{"var":"integers"},false]} | ✅ |
| {"filter":[{"var":"integers"},{">=":[{"var":""},2]}]} | ✅ |
| {"filter":[{"var":"integers"},{"%":[{"var":""},2]}]} | ✅ |
| {"map":[{"var":"integers"},{"*":[{"var":""},2]}]} | ✅ |
| {"map":[{"var":"integers"},{"*":[{"var":""},2]}]} | ✅ |
| {"map":[{"var":"desserts"},{"var":"qty"}]} | ✅ |
| {"reduce":[{"var":"integers"},{"+":[{"var":"current"},{"var":"accumulator"}]},0]} | ✅ |
| {"reduce":[{"var":"integers"},{"+":[{"var":"current"},{"var":"accumulator"}]},{"var":"start_with"}]} | ✅ |
| {"reduce":[{"var":"integers"},{"+":[{"var":"current"},{"var":"accumulator"}]},0]} | ✅ |
| {"reduce":[{"var":"integers"},{"*":[{"var":"current"},{"var":"accumulator"}]},1]} | ✅ |
| {"reduce":[{"var":"integers"},{"*":[{"var":"current"},{"var":"accumulator"}]},0]} | ✅ |
| {"reduce":[{"var":"desserts"},{"+":[{"var":"accumulator"},{"var":"current.qty"}]},0]} | ✅ |
| {"all":[{"var":"integers"},{">=":[{"var":""},1]}]} | ✅ |
| {"all":[{"var":"integers"},{"==":[{"var":""},1]}]} | ✅ |
| {"all":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"all":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"all":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |
| {"all":[{"var":"items"},{">":[{"var":"qty"},1]}]} | ✅ |
| {"all":[{"var":"items"},{"<":[{"var":"qty"},1]}]} | ✅ |
| {"all":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |
| {"none":[{"var":"integers"},{">=":[{"var":""},1]}]} | ✅ |
| {"none":[{"var":"integers"},{"==":[{"var":""},1]}]} | ✅ |
| {"none":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"none":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"none":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |
| {"none":[{"var":"items"},{">":[{"var":"qty"},1]}]} | ✅ |
| {"none":[{"var":"items"},{"<":[{"var":"qty"},1]}]} | ✅ |
| {"none":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |
| {"some":[{"var":"integers"},{">=":[{"var":""},1]}]} | ✅ |
| {"some":[{"var":"integers"},{"==":[{"var":""},1]}]} | ✅ |
| {"some":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"some":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"some":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |
| {"some":[{"var":"items"},{">":[{"var":"qty"},1]}]} | ✅ |
| {"some":[{"var":"items"},{"<":[{"var":"qty"},1]}]} | ✅ |
| {"some":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |

# ./suites/array/some.json — 11/13 passed

| Test | Result |
|------|--------|
| Some elements are positive | ✅ |
| No elements are positive | ✅ |
| Some objects meet age requirement | ✅ |
| Some objects meet stock threshold | ✅ |
| Empty array returns false | ✅ |
| Null array should throw | ❌ |
| Missing array returns error | ❌ |
| Null predicate returns false | ✅ |
| Some with compound conditions | ✅ |
| Some with nested array operations | ✅ |
| Some with mixed types coercion to boolean | ✅ |
| Some with string operations | ✅ |
| Some with empty strings | ✅ |

# ./suites/scopes.json — 0/4 passed

| Test | Result |
|------|--------|
| Map can add each number to index | ❌ |
| Map can add each number to value from context | ❌ |
| Filter can use parent context to filter | ❌ |
| Access an escaped key from above | ❌ |

# ./suites/array/map.json — 11/14 passed

| Test | Result |
|------|--------|
| Map with identity function | ✅ |
| Map with multiplication | ✅ |
| Map extracting single field from objects | ✅ |
| Map with complex object transformation | ✅ |
| Map on null array returns empty array | ✅ |
| Map on empty array returns empty array | ✅ |
| Map with null mapper should throw | ❌ |
| Map with null array should throw | ❌ |
| Map with nested logic operations | ✅ |
| Map with string operations | ✅ |
| Map with nested path access | ✅ |
| Map with missing nested paths | ❌ |
| Map with numeric coercion | ✅ |
| Map with boolean coercion | ✅ |

# ./suites/array/filter.json — 10/12 passed

| Test | Result |
|------|--------|
| Filter positive numbers | ✅ |
| Filter even numbers | ✅ |
| Filter objects by property value | ✅ |
| Filter with multiple conditions | ✅ |
| Filter on null array returns empty array | ✅ |
| Filter on empty array returns empty array | ✅ |
| Filter with null predicate should throw | ❌ |
| Filter with null array should throw | ❌ |
| Filter with nested logic | ✅ |
| Filter with string operations | ✅ |
| Filter with type coercion | ✅ |
| Filter with deep path access | ✅ |

# ./suites/comparison/softEquals.json — 27/35 passed

| Test | Result |
|------|--------|
| == with 3 arguments | ❌ |
| == with 3 arguments failing | ❌ |
| == is lazily evaluated | ❌ |
| == with 1 argument | ✅ |
| == with direct argument | ✅ |
| == with empty argument | ✅ |
| == with (false, true) | ✅ |
| == with (true, false) | ✅ |
| == with (false, false) | ✅ |
| == with (true, true) | ✅ |
| == with (a, b) | ✅ |
| == with (b, a) | ✅ |
| == with (a, a) | ✅ |
| == with (2024-01-01, 2024-01-02) | ✅ |
| == with (2024-01-02, 2024-01-01) | ✅ |
| == with (2024-01-01, 2024-01-01) | ✅ |
| == with (2023n, 2024-01-01s) | ✅ |
| == with (5s, 3n) | ✅ |
| == with (21s, 3n) | ✅ |
| == with (21n, 3s) | ✅ |
| == with (3s, 21n) | ✅ |
| == with (3n, 21s) | ✅ |
| == with (3n, 3s) | ✅ |
| == with (3s, 3n) | ✅ |
| == with (1n, As) | ✅ |
| == with (null, 1) | ✅ |
| == with (1, null) | ✅ |
| == with (null, 0) | ❌ |
| == with (null, true) | ✅ |
| == with (1, true) | ✅ |
| == with (0, false) | ✅ |
| == with [] and [1] | ❌ |
| == with [1] and 5 | ❌ |
| == with {} and 1 | ❌ |
| == with 1 and {} | ❌ |

# ./suites/arithmetic/multiply.json — 28/28 passed

| Test | Result |
|------|--------|
| Multiply | ✅ |
| Multiply with Multiple Operands | ✅ |
| Multiply with Multiple Operands (2) | ✅ |
| Multiply with Negative Numbers | ✅ |
| Multiply with Strings | ✅ |
| Multiply with Booleans | ✅ |
| Multiply with Multiple Value Types | ✅ |
| Multiply with Multiple Value Types (2) | ✅ |
| Multiply with Multiple Value Types (3) | ✅ |
| Multiply with Single Operand (Number) | ✅ |
| Multiply with Single Operand, Direct (Number) | ✅ |
| Multiply with Single Operand, Direct (0) | ✅ |
| Multiply Operator with Single Operand (Number) | ✅ |
| Multiply Operator with Single Operand (Negative Number) | ✅ |
| Multiply with zero operands is 1 (Product) | ✅ |
| Multiply Operator with Single Operand, Direct (Number) | ✅ |
| Multiply Operator with Single Operand, Direct (0) | ✅ |
| Multiply Operator with Single Operand (String) | ✅ |
| Multiply Operator with Single Operand, Direct (Negative Number String) | ✅ |
| Multiply Operator with Single Operand, Direct (String 0) | ✅ |
| Multiply Operator with Single Operand, Direct (true) | ✅ |
| Multiply Operator with Single Operand, Direct (false) | ✅ |
| Multiply Operator with Single Operand, Direct (Empty String) | ✅ |
| Multiply Operator with a Single Operand, Direct (null) | ✅ |
| Multiply with val | ✅ |
| Multiply with string produces NaN | ✅ |
| Multiply with a single string produces NaN | ✅ |
| Multiply with Array produces NaN | ✅ |

# ./suites/comparison/softNotEquals.json — 27/34 passed

| Test | Result |
|------|--------|
| != with 3 arguments | ❌ |
| != is lazily evaluated | ❌ |
| != with 1 argument | ✅ |
| != with direct argument | ✅ |
| != with empty argument | ✅ |
| != with (false, true) | ✅ |
| != with (true, false) | ✅ |
| != with (false, false) | ✅ |
| != with (true, true) | ✅ |
| != with (a, b) | ✅ |
| != with (b, a) | ✅ |
| != with (a, a) | ✅ |
| != with (2024-01-01, 2024-01-02) | ✅ |
| != with (2024-01-02, 2024-01-01) | ✅ |
| != with (2024-01-01, 2024-01-01) | ✅ |
| != with (2023n, 2024-01-01s) | ✅ |
| != with (5s, 3n) | ✅ |
| != with (21s, 3n) | ✅ |
| != with (21n, 3s) | ✅ |
| != with (3s, 21n) | ✅ |
| != with (3n, 21s) | ✅ |
| != with (3n, 3s) | ✅ |
| != with (3s, 3n) | ✅ |
| != with (1n, As) | ✅ |
| != with (null, 1) | ✅ |
| != with (1, null) | ✅ |
| != with (null, 0) | ❌ |
| != with (null, true) | ✅ |
| != with (1, true) | ✅ |
| != with (0, false) | ✅ |
| != with [] and [1] | ❌ |
| != with [1] and 5 | ❌ |
| != with {} and 1 | ❌ |
| != with 1 and {} | ❌ |

# ./suites/comparison/lessThan.json — 33/45 passed

| Test | Result |
|------|--------|
| < with 3 arguments | ✅ |
| < is lazily evaluated | ❌ |
| < with 1 argument | ❌ |
| < with direct argument | ❌ |
| < with empty argument | ✅ |
| < with (false, true) | ✅ |
| < with (true, false) | ✅ |
| < with (false, false) | ✅ |
| < with (true, true) | ✅ |
| < with (a, b) | ❌ |
| < with (b, a) | ❌ |
| < with (a, a) | ❌ |
| < with (2024-01-01, 2024-01-02) | ❌ |
| < with (2024-01-02, 2024-01-01) | ❌ |
| < with (2024-01-01, 2024-01-01) | ❌ |
| < with (2023, 2024-01-01) | ❌ |
| < with (2023n, 2024-01-01s) | ✅ |
| < with (5s, 3n) | ✅ |
| < with (21s, 3n) | ✅ |
| < with (21n, 3s) | ✅ |
| < with (3s, 21n) | ✅ |
| < with (3n, 21s) | ✅ |
| < with (3n, 3s) | ✅ |
| < with (3s, 3n) | ✅ |
| < with (3n, 3n) | ✅ |
| < with (3s, 3s) | ✅ |
| < with (3n, 3) | ✅ |
| < with (3, 3n) | ✅ |
| < with (3s, 3) | ✅ |
| < with (3, 3s) | ✅ |
| < with (3n, 3n) | ✅ |
| < with (3s, 3s) | ✅ |
| < with (3n, 3s) | ✅ |
| < with (3s, 3n) | ✅ |
| < with (1n, As) | ✅ |
| < with (null, 1) | ✅ |
| < with (1, null) | ✅ |
| < with (null, 0) | ✅ |
| < with (null, true) | ✅ |
| < with (1, true) | ✅ |
| < with (0, false) | ✅ |
| < with [] and [1] | ✅ |
| < with [1] and 5 | ✅ |
| < with {} and 1 | ❌ |
| < with 1 and {} | ❌ |

# ./suites/val.json — 13/13 passed

| Test | Result |
|------|--------|
| Fetches a value | ✅ |
| Fetches a nested value | ✅ |
| Fetches a value from an empty key | ✅ |
| Fetches a value from a nested empty key | ✅ |
| Fetches a value from an array | ✅ |
| Fetches a value from an array in an object | ✅ |
| Fetches a value from a doubly nested empty key | ✅ |
| Fetches a value from a key that is purely a dot | ✅ |
| Fetching a value from null returns null | ✅ |
| Fetching a value from a null fetched value returns null | ✅ |
| Fetches the entire context | ✅ |
| Fetches the entire context for a nested key | ✅ |
| Using val in a map | ✅ |

# ./suites/arithmetic/minus.json — 21/22 passed

| Test | Result |
|------|--------|
| Subtraction | ✅ |
| Subtraction (2) | ✅ |
| Subtraction with Multiple Operands | ✅ |
| Subtraction with Negative Numbers | ✅ |
| Subtraction with Strings | ✅ |
| Subtraction with Booleans | ✅ |
| Subtraction with Multiple Value Types | ✅ |
| Minus Operator with Single Operand (Number) | ✅ |
| Minus Operator with Single Operand (Negative Number) | ✅ |
| Minus with zero operands is an error | ❌ |
| Minus Operator with Single Operand, Direct (Number) | ✅ |
| Minus Operator with Single Operand, Direct (0) | ✅ |
| Minus Operator with Single Operand (String) | ✅ |
| Minus Operator with Single Operand, Direct (Negative Number String) | ✅ |
| Minus Operator with Single Operand, Direct (String 0) | ✅ |
| Minus Operator with Single Operand, Direct (true) | ✅ |
| Minus Operator with Single Operand, Direct (false) | ✅ |
| Minus Operator with Single Operand, Direct (Empty String) | ✅ |
| Minus Operator with a Single Operand, Direct (null) | ✅ |
| Subtraction with val | ✅ |
| Subtraction with string produces NaN | ✅ |
| Subtraction with Array produces NaN | ✅ |

# ./suites/comparison/lessThanEquals.json — 17/20 passed

| Test | Result |
|------|--------|
| <= is lazily evaluated | ❌ |
| <= with (2023n, 2024-01-01s) | ✅ |
| <= with (5s, 3n) | ✅ |
| <= with (21s, 3n) | ✅ |
| <= with (21n, 3s) | ✅ |
| <= with (3s, 21n) | ✅ |
| <= with (3n, 21s) | ✅ |
| <= with (3n, 3s) | ✅ |
| <= with (3s, 3n) | ✅ |
| <= with (1n, As) | ✅ |
| <= with (null, 1) | ✅ |
| <= with (1, null) | ✅ |
| <= with (null, 0) | ✅ |
| <= with (null, true) | ✅ |
| <= with (1, true) | ✅ |
| <= with (0, false) | ✅ |
| <= with [] and [1] | ✅ |
| <= with [1] and 5 | ✅ |
| <= with {} and 1 | ❌ |
| <= with 1 and {} | ❌ |

# ./suites/control/or.json — 15/24 passed

| Test | Result |
|------|--------|
| Two true values returns first true | ✅ |
| false and true returns true | ✅ |
| true and false returns true | ✅ |
| Two false values returns last false | ✅ |
| Empty OR returns false | ✅ |
| OR with single truthy value returns that value | ✅ |
| OR with single falsy value returns that value | ❌ |
| OR with multiple values returns first truthy value | ✅ |
| When all values are falsy, the last falsy value should be returned | ❌ |
| OR with a single empty array returns empty array | ❌ |
| OR with a single zero returns zero | ❌ |
| OR with a single empty string returns empty string | ❌ |
| OR with 2 truthy values returns first truthy value | ✅ |
| Empty array then true returns true | ✅ |
| Zero then true returns true | ✅ |
| Empty string then true returns true | ✅ |
| String zero is truthy and returned | ✅ |
| OR with non-array arguments should throw | ❌ |
| OR will not interpret the second argument if the first is true | ❌ |
| OR will not interpret the second argument if the first is truthy | ❌ |
| OR will not interpret the nth argument if any value before it is truthy | ❌ |
| OR with nested operations evaluates left to right | ✅ |
| OR with nested logic | ✅ |
| OR with deeply nested operations | ✅ |

# ./suites/comparison/strictEquals.json — 28/31 passed

| Test | Result |
|------|--------|
| === with 3 arguments | ❌ |
| === with 3 arguments failing | ❌ |
| === is lazily evaluated | ❌ |
| === with 1 argument | ✅ |
| === with direct argument | ✅ |
| === with empty argument | ✅ |
| === with (false, true) | ✅ |
| === with (true, false) | ✅ |
| === with (false, false) | ✅ |
| === with (true, true) | ✅ |
| === with (a, b) | ✅ |
| === with (b, a) | ✅ |
| === with (a, a) | ✅ |
| === with (2024-01-01, 2024-01-02) | ✅ |
| === with (2024-01-02, 2024-01-01) | ✅ |
| === with (2024-01-01, 2024-01-01) | ✅ |
| === with (2023n, 2024-01-01s) | ✅ |
| === with (5s, 3n) | ✅ |
| === with (21s, 3n) | ✅ |
| === with (21n, 3s) | ✅ |
| === with (3s, 21n) | ✅ |
| === with (3n, 21s) | ✅ |
| === with (3n, 3s) | ✅ |
| === with (3s, 3n) | ✅ |
| === with (1n, As) | ✅ |
| === with (null, 1) | ✅ |
| === with (1, null) | ✅ |
| === with (null, 0) | ✅ |
| === with (null, true) | ✅ |
| === with (1, true) | ✅ |
| === with (0, false) | ✅ |

# ./suites/val-compat.json — 59/60 passed

| Test | Result |
|------|--------|
| [1,{"var":"x"},3] | ✅ |
| {"if":[{"var":"x"},[{"var":"y"}],99]} | ✅ |
| {"var":["a"]} | ✅ |
| {"var":["b"]} | ✅ |
| {"var":["a"]} | ✅ |
| {"var":"a"} | ✅ |
| {"var":"b"} | ✅ |
| {"var":"a"} | ✅ |
| {"var":"a.b"} | ✅ |
| {"var":"a.q"} | ✅ |
| {"var":1} | ✅ |
| {"var":"1"} | ❌ |
| {"var":"1.1"} | ✅ |
| {"and":[{"<":[{"var":"temp"},110]},{"==":[{"var":"pie.filling"},"apple"]}]} | ✅ |
| {"var":[{"?:":[{"<":[{"var":"temp"},110]},"pie.filling","pie.eta"]}]} | ✅ |
| {"in":[{"var":"filling"},["apple","cherry"]]} | ✅ |
| {"var":"a.b.c"} | ✅ |
| {"var":"a.b.c"} | ✅ |
| {"var":"a.b.c"} | ✅ |
| {"var":""} | ✅ |
| {"val":[]} | ✅ |
| {"missing":{"merge":["vin",{"if":[{"var":"financing"},["apr"],[]]}]}} | ✅ |
| {"missing":{"merge":["vin",{"if":[{"var":"financing"},["apr"],[]]}]}} | ✅ |
| {"filter":[{"var":"integers"},true]} | ✅ |
| {"filter":[{"var":"integers"},false]} | ✅ |
| {"filter":[{"var":"integers"},{">=":[{"var":""},2]}]} | ✅ |
| {"filter":[{"var":"integers"},{"%":[{"var":""},2]}]} | ✅ |
| {"map":[{"var":"integers"},{"*":[{"var":""},2]}]} | ✅ |
| {"map":[{"var":"integers"},{"*":[{"var":""},2]}]} | ✅ |
| {"map":[{"var":"desserts"},{"var":"qty"}]} | ✅ |
| {"reduce":[{"var":"integers"},{"+":[{"var":"current"},{"var":"accumulator"}]},0]} | ✅ |
| {"reduce":[{"var":"integers"},{"+":[{"var":"current"},{"var":"accumulator"}]},{"var":"start_with"}]} | ✅ |
| {"reduce":[{"var":"integers"},{"+":[{"var":"current"},{"var":"accumulator"}]},0]} | ✅ |
| {"reduce":[{"var":"integers"},{"*":[{"var":"current"},{"var":"accumulator"}]},1]} | ✅ |
| {"reduce":[{"var":"integers"},{"*":[{"var":"current"},{"var":"accumulator"}]},0]} | ✅ |
| {"reduce":[{"var":"desserts"},{"+":[{"var":"accumulator"},{"var":"current.qty"}]},0]} | ✅ |
| {"all":[{"var":"integers"},{">=":[{"var":""},1]}]} | ✅ |
| {"all":[{"var":"integers"},{"==":[{"var":""},1]}]} | ✅ |
| {"all":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"all":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"all":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |
| {"all":[{"var":"items"},{">":[{"var":"qty"},1]}]} | ✅ |
| {"all":[{"var":"items"},{"<":[{"var":"qty"},1]}]} | ✅ |
| {"all":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |
| {"none":[{"var":"integers"},{">=":[{"var":""},1]}]} | ✅ |
| {"none":[{"var":"integers"},{"==":[{"var":""},1]}]} | ✅ |
| {"none":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"none":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"none":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |
| {"none":[{"var":"items"},{">":[{"var":"qty"},1]}]} | ✅ |
| {"none":[{"var":"items"},{"<":[{"var":"qty"},1]}]} | ✅ |
| {"none":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |
| {"some":[{"var":"integers"},{">=":[{"var":""},1]}]} | ✅ |
| {"some":[{"var":"integers"},{"==":[{"var":""},1]}]} | ✅ |
| {"some":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"some":[{"var":"integers"},{"<":[{"var":""},1]}]} | ✅ |
| {"some":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |
| {"some":[{"var":"items"},{">":[{"var":"qty"},1]}]} | ✅ |
| {"some":[{"var":"items"},{"<":[{"var":"qty"},1]}]} | ✅ |
| {"some":[{"var":"items"},{">=":[{"var":"qty"},1]}]} | ✅ |

# ./suites/array/merge.json — 7/8 passed

| Test | Result |
|------|--------|
| Merge two arrays | ✅ |
| Merge array variables | ✅ |
| Merge with empty array | ✅ |
| Merge multiple empty arrays | ✅ |
| Merge with null should be ignored | ❌ |
| Merge without arguments returns empty array | ✅ |
| Merge arrays of objects | ✅ |
| Merge with filtered arrays | ✅ |

# ./suites/exists.json — 0/8 passed

| Test | Result |
|------|--------|
| Checks if a normal key exists | ❌ |
| Checks if a normal key exists (array) | ❌ |
| Checks if a normal key exists (false) | ❌ |
| Checks if an empty key exists (true) | ❌ |
| Checks if an empty key exists (false) | ❌ |
| Checks if a nested key exists | ❌ |
| Checks if a nested key exists (false) | ❌ |
| Checks if a null value exists | ❌ |

# ./suites/comparison/greaterThanEquals.json — 17/28 passed

| Test | Result |
|------|--------|
| >= with 3 arguments | ✅ |
| >= with 3 arguments failing | ✅ |
| >= is lazily evaluated | ❌ |
| >= with 1 argument | ❌ |
| >= with direct argument | ❌ |
| >= with empty argument | ✅ |
| >= with (false, true) | ✅ |
| >= with (true, false) | ✅ |
| >= with (false, false) | ✅ |
| >= with (true, true) | ✅ |
| >= with (a, b) | ❌ |
| >= with (b, a) | ❌ |
| >= with (a, a) | ❌ |
| >= with (2024-01-01, 2024-01-02) | ❌ |
| >= with (2024-01-02, 2024-01-01) | ❌ |
| >= with (2024-01-01, 2024-01-01) | ❌ |
| >= with (1n, As) | ✅ |
| >= with (1n, As) | ✅ |
| >= with (null, 1) | ✅ |
| >= with (1, null) | ✅ |
| >= with (null, 0) | ✅ |
| >= with (null, true) | ✅ |
| >= with (1, true) | ✅ |
| >= with (0, false) | ✅ |
| >= with [] and [1] | ✅ |
| >= with [1] and 5 | ✅ |
| >= with {} and 1 | ❌ |
| >= with 1 and {} | ❌ |

# ./suites/chained.json — 2/7 passed

| Test | Result |
|------|--------|
| Standard Max | ✅ |
| Standard Max, Single Argument Sugared | ✅ |
| Max with Logic Chaining | ❌ |
| Cat with Logic Chaining | ❌ |
| Cat with Logic Chaining (Simple) | ❌ |
| Max with Logic Chaining (Complex) | ❌ |
| Addition Chained w/ Merge | ❌ |

# ./suites/coalesce.json — 0/15 passed

| Test | Result |
|------|--------|
| Coalesces a string alone | ❌ |
| Coalesces a number alone | ❌ |
| Coalesces a boolean alone | ❌ |
| Coalesces an object from context alone | ❌ |
| Empty behavior | ❌ |
| Coalesces a string with nulls before | ❌ |
| Coalesces a string with multiple nulls before | ❌ |
| Coalesces a string with nulls after | ❌ |
| Coalesces a string with nulls both before and after | ❌ |
| Coalesces a number with nulls both before and after | ❌ |
| Uses the first non-null value | ❌ |
| Uses the first non-null value, even if it is false | ❌ |
| Uses the first non-null value from context | ❌ |
| Uses the first non-null value from context (with person undefined) | ❌ |
| Uses the first non-null value from context (without any context) | ❌ |

# ./suites/comparison/strictNotEquals.json — 28/30 passed

| Test | Result |
|------|--------|
| !== with 3 arguments failing | ❌ |
| !== is lazily evaluated | ❌ |
| !== with 1 argument | ✅ |
| !== with direct argument | ✅ |
| !== with empty argument | ✅ |
| !== with (false, true) | ✅ |
| !== with (true, false) | ✅ |
| !== with (false, false) | ✅ |
| !== with (true, true) | ✅ |
| !== with (a, b) | ✅ |
| !== with (b, a) | ✅ |
| !== with (a, a) | ✅ |
| !== with (2024-01-01, 2024-01-02) | ✅ |
| !== with (2024-01-02, 2024-01-01) | ✅ |
| !== with (2024-01-01, 2024-01-01) | ✅ |
| !== with (2023n, 2024-01-01s) | ✅ |
| !== with (5s, 3n) | ✅ |
| !== with (21s, 3n) | ✅ |
| !== with (21n, 3s) | ✅ |
| !== with (3s, 21n) | ✅ |
| !== with (3n, 21s) | ✅ |
| !== with (3n, 3s) | ✅ |
| !== with (3s, 3n) | ✅ |
| !== with (1n, As) | ✅ |
| !== with (null, 1) | ✅ |
| !== with (1, null) | ✅ |
| !== with (null, 0) | ✅ |
| !== with (null, true) | ✅ |
| !== with (1, true) | ✅ |
| !== with (0, false) | ✅ |

# ./suites/array/none.json — 11/13 passed

| Test | Result |
|------|--------|
| None of the elements are negative | ✅ |
| Some elements are negative (none returns false) | ✅ |
| None of the objects are underage | ✅ |
| None of items are out of stock | ✅ |
| Empty array returns true | ✅ |
| Null array should throw | ❌ |
| Missing array returns error | ❌ |
| Null predicate returns true | ✅ |
| None with compound conditions | ✅ |
| None with nested array operations | ✅ |
| None with mixed types coercion to boolean | ✅ |
| None with string operations | ✅ |
| None with zero length strings | ✅ |

# ./suites/control/if.json — 37/44 passed

| Test | Result |
|------|--------|
| true is true, and uses the then | ✅ |
| false is false, and uses the fallback | ✅ |
| null is falsy | ✅ |
| Objects are always truthy, even without keys. | ❌ |
| Objects are always truthy, with keys defined | ✅ |
| Empty array is falsy | ✅ |
| Array with single element is truthy | ✅ |
| Array with multiple elements is truthy | ✅ |
| Empty string is falsy | ✅ |
| Any non-empty string is truthy | ✅ |
| Any non-empty string is truthy, even 0 | ✅ |
| No arguments is just null. | ✅ |
| If no then is defined when true, it'll just return null. | ✅ |
| If no fallback is defined when falsy, it'll just return null. | ✅ |
| If no then is defined when truthy, it'll just return null. | ✅ |
| When truthy, it'll return the 'then' even if no fallback is defined. | ✅ |
| When falsy, it'll return null if the fallback is not defined, even if the 'then' is defined. | ✅ |
| Returns the first truthy if condition | ✅ |
| Returns the first truthy then condition, even if multiple conditions are true | ✅ |
| Retuns the first truthy condition, with the fallback defined. | ✅ |
| Returns the first truthy condition, with the fallback defined; multiple true conditions. | ✅ |
| Returns the first truthy condition, with the first condition falsy. Fallback defined. | ✅ |
| Returns the first truthy condition, in this case it's the 2nd one. | ✅ |
| When none of the conditions are true, it returns the fallback. | ✅ |
| When none of the conditions are true, it returns the fallback. In this case the fallback is not defined, so it is null. | ✅ |
| 3 Conditions, all falsy. Returns fallback. | ✅ |
| 3 Conditions, all falsy, no fallback defined. Returns null. | ✅ |
| First condition truthy, 3 conditions. | ✅ |
| 2nd Condition is Truthy | ✅ |
| Third Condition is Truthy | ✅ |
| Returns first truthy value, some conditions truthy | ✅ |
| Returns first truthy value, some conditions truthy (2) | ✅ |
| Returns first truthy value, some conditions truthy (3) | ✅ |
| Returns first truthy value, all conditions truthy | ✅ |
| Returns first truthy value, some conditions truthy (4) | ✅ |
| Returns first truthy value, some conditions truthy (5) | ✅ |
| Returns first truthy value, some conditions truthy (6) | ✅ |
| Returns first truthy value, some conditions truthy (7) | ✅ |
| Returns first truthy value, some conditions truthy (8) | ❌ |
| If with non-array arguments throws | ❌ |
| If will not evaluate then branch if the condition is false | ❌ |
| If will not evaluate fallback branch if the condition is true | ❌ |
| If will not evaluate other branches or checks if a prior condition is true | ❌ |
| No branches except the fallback check will be evaluated if the condition is false | ❌ |

# ./suites/arithmetic/minus.extra.json — 0/3 passed

| Test | Result |
|------|--------|
| Minus with dynamic empty array | ❌ |
| Minus with dynamic unary array | ❌ |
| Minus with dynamic array | ❌ |

# ./suites/control/doublebang.json — 22/23 passed

| Test | Result |
|------|--------|
| Double bang on true returns true | ✅ |
| Double bang on false returns false | ✅ |
| Double bang on null returns false | ✅ |
| Double bang on empty array returns false | ✅ |
| Double bang on non-empty array returns true | ✅ |
| Double bang on empty string returns false | ✅ |
| Double bang on non-empty string returns true | ✅ |
| Double bang on zero returns false | ✅ |
| Double bang on one returns true | ✅ |
| Double bang on string zero returns true | ✅ |
| Double bang on empty object returns true | ❌ |
| Double bang on empty string returns false | ✅ |
| Double bang preserves truthy values | ✅ |
| Double bang without arguments return false | ✅ |
| Double bang with nested var operation | ✅ |
| Double bang with nested comparison | ✅ |
| Double bang with nested AND | ✅ |
| Double bang with nested OR | ✅ |
| Double bang with missing variable returns false | ✅ |
| Double bang after NOT negates the NOT | ✅ |
| Double bang with undefined variable | ✅ |
| Double bang on negative number returns true | ✅ |
| Double bang on NaN returns false | ✅ |

# ./suites/throw.json — 0/3 passed

| Test | Result |
|------|--------|
| Throws hello as an error | ❌ |
| Throwing NaN produces an error object or measured equivalent (equivalence class test) | ❌ |
| Can throw an error object | ❌ |

# ./suites/val.extra.json — 0/3 passed

| Test | Result |
|------|--------|
| Climb up to get adder | ❌ |
| Climb up to get index | ❌ |
| Nested get adder | ❌ |

# ./suites/comparison/greaterThan.json — 24/35 passed

| Test | Result |
|------|--------|
| > with 3 arguments | ✅ |
| > with 3 arguments failing | ✅ |
| > is lazily evaluated | ❌ |
| > with 1 argument | ❌ |
| > with direct argument | ❌ |
| > with empty argument | ✅ |
| > with (false, true) | ✅ |
| > with (true, false) | ✅ |
| > with (false, false) | ✅ |
| > with (true, true) | ✅ |
| > with (a, b) | ❌ |
| > with (b, a) | ❌ |
| > with (a, a) | ❌ |
| > with (2024-01-01, 2024-01-02) | ❌ |
| > with (2024-01-02, 2024-01-01) | ❌ |
| > with (2024-01-01, 2024-01-01) | ❌ |
| > with (2023n, 2024-01-01s) | ✅ |
| > with (5s, 3n) | ✅ |
| > with (21s, 3n) | ✅ |
| > with (21n, 3s) | ✅ |
| > with (3s, 21n) | ✅ |
| > with (3n, 21s) | ✅ |
| > with (3n, 3s) | ✅ |
| > with (3s, 3n) | ✅ |
| > with (1n, As) | ✅ |
| > with (null, 1) | ✅ |
| > with (1, null) | ✅ |
| > with (null, 0) | ✅ |
| > with (null, true) | ✅ |
| > with (1, true) | ✅ |
| > with (0, false) | ✅ |
| > with [] and [1] | ✅ |
| > with [1] and 5 | ✅ |
| > with {} and 1 | ❌ |
| > with 1 and {} | ❌ |

# ./suites/arithmetic/divide.json — 23/31 passed

| Test | Result |
|------|--------|
| Divide | ✅ |
| Divide to Decimal | ✅ |
| Divide with Multiple Operands | ✅ |
| Divide with Multiple Operands (2) | ✅ |
| Divide with Negative Numbers | ✅ |
| Divide with Strings | ✅ |
| Divide with Booleans | ✅ |
| Divide with Multiple Value Types | ✅ |
| Divide with Multiple Value Types (2) | ✅ |
| Divide with Single Operand (Number) | ✅ |
| Divide with zero operands is an error | ❌ |
| Divide with Single Operand, Direct (Number) | ✅ |
| Divide with Single Operand, Direct (0) | ❌ |
| Divide Operator with Single Operand (Number) | ✅ |
| Divide Operator with Single Operand (Negative Number) | ✅ |
| Divide Operator with Single Operand, Direct (Number) | ✅ |
| Divide Operator with Single Operand, Direct (2) | ❌ |
| Divide Operator with Single Operand, Direct (0) | ❌ |
| Divide Operator with Single Operand (String) | ✅ |
| Divide Operator with Single Operand, Direct (Negative Number String) | ✅ |
| Divide Operator with Single Operand, Direct (String 0) | ❌ |
| Divide Operator with Single Operand, Direct (true) | ✅ |
| Divide Operator with Single Operand, Direct (false) | ❌ |
| Divide Operator with Single Operand, Direct (Empty String) | ❌ |
| Divide Operator with a Single Operand, Direct (null) | ❌ |
| Divide with val | ✅ |
| Divide by Zero | ✅ |
| Divide with String produces NaN | ✅ |
| Divide with Array produces NaN | ✅ |
| Any division by zero should return NaN | ✅ |
| Any division by zero should return NaN (2) | ✅ |

# ./suites/arithmetic/plus.extra.json — 0/3 passed

| Test | Result |
|------|--------|
| Plus operator with empty array dynamic | ❌ |
| Plus operator with unary array dynamic | ❌ |
| Plus operator with array dynamic | ❌ |

# ./suites/try.json — 0/18 passed

| Test | Result |
|------|--------|
| Coalesce an error | ❌ |
| Coalesce an error emitted from an operator | ❌ |
| Try is variadic | ❌ |
| Panics if none of the values are valid | ❌ |
| Panics if none of the values are valid (2) | ❌ |
| Panics if none of the values are valid (3) | ❌ |
| Panics when the only argument is an error | ❌ |
| Panic with an error emitted from an operator | ❌ |
| Panic within an iterator | ❌ |
| Panic based on an error emitted from an if | ❌ |
| Try can work further up the AST with Exceptions | ❌ |
| The context switches for the try coalescing to the previous error | ❌ |
| The context switches for the try coalescing to the previous error (2) | ❌ |
| The context switches for the try coalescing to the previous error (3) | ❌ |
| Error can pull from an error object | ❌ |
| Try can work further up the AST with Exceptions, and return the error | ❌ |
| Handles NaN Explicitly | ❌ |
| Did not NaN, so it errored | ❌ |

# ./suites/array/reduce.json — 8/9 passed

| Test | Result |
|------|--------|
| Reduce array with sum | ✅ |
| Reduce array with multiplication | ✅ |
| Reduce objects to sum of specific field | ✅ |
| Reduce to create aggregated object | ✅ |
| Reduce empty array returns initial value | ✅ |
| Reduce null array returns initial value | ✅ |
| Initial value is optional | ❌ |
| Reduce with string concatenation | ✅ |
| Reduce with conditional logic | ✅ |

# ./suites/try.extra.json — 0/1 passed

| Test | Result |
|------|--------|
| Try can work further up the AST with Exceptions; Grabbing other Context value | ❌ |

# ./suites/arithmetic/multiply.extra.json — 0/3 passed

| Test | Result |
|------|--------|
| Multiply with dynamic empty array | ❌ |
| Multiply with dynamic unary array | ❌ |
| Multiply with dynamic array | ❌ |

# ./suites/arithmetic/modulo.extra.json — 0/2 passed

| Test | Result |
|------|--------|
| Modulo with dynamic array invalid | ❌ |
| Modulo with dynamic array invalid | ❌ |

# ./suites/string/substr.json — 12/12 passed

| Test | Result |
|------|--------|
| Substr from start index | ✅ |
| Substr with negative start index | ✅ |
| Substr with start and positive length | ✅ |
| Substr with negative start and positive length | ✅ |
| Substr with start and length | ✅ |
| Substr with negative start and length | ✅ |
| Substr with negative length from end | ✅ |
| Substr with positive start and negative length | ✅ |
| Substr with empty string | ✅ |
| Substr with start beyond string length | ✅ |
| Substr with negative start beyond string length | ✅ |
| Substr with non-string input returns empty | ✅ |

# ./suites/arithmetic/divide.extra.json — 0/3 passed

| Test | Result |
|------|--------|
| Divide with dynamic empty array | ❌ |
| Divide with dynamic unary array | ❌ |
| Divide with dynamic array | ❌ |

# ./suites/control/not.json — 22/23 passed

| Test | Result |
|------|--------|
| NOT true returns false | ✅ |
| NOT false returns true | ✅ |
| NOT null returns true | ✅ |
| NOT empty array returns true | ✅ |
| NOT non-empty array returns false | ✅ |
| NOT empty string returns true | ✅ |
| NOT non-empty string returns false | ✅ |
| NOT zero returns true | ✅ |
| NOT one returns false | ✅ |
| NOT string zero returns false | ✅ |
| NOT empty object returns false | ❌ |
| NOT with non-array argument | ✅ |
| NOT with non-array argument false | ✅ |
| NOT with non-array argument 0 | ✅ |
| NOT with non-array argument 1 | ✅ |
| NOT without arguments returns true | ✅ |
| NOT with nested var operation | ✅ |
| NOT with nested comparison | ✅ |
| NOT with nested AND | ✅ |
| NOT with nested OR | ✅ |
| NOT with missing variable returns true | ✅ |
| Double NOT preserves original boolean | ✅ |
| NOT with undefined variable | ✅ |

# ./suites/control/and.json — 20/25 passed

| Test | Result |
|------|--------|
| Two true values should be true | ✅ |
| false and true should be false | ✅ |
| true and false should be false | ✅ |
| Two false values should be false | ✅ |
| All true values should be true | ✅ |
| Any false value should be false | ✅ |
| And with a single false value should be false | ✅ |
| When all values are truthy, the last truthy value should be returned | ✅ |
| When all values are truthy, the last truthy value should be returned (2) | ❌ |
| And with a single falsey value should be return the falsy value | ✅ |
| And with a single falsey value should be return the falsy value (2) | ✅ |
| And with a single falsey value should be return the falsy value (3) | ✅ |
| And with a single true value should be true | ✅ |
| And with 2 truthy values should return the last truthy value | ✅ |
| And with a truthy value and a false value should return the false value | ✅ |
| And with a truthy value and a false value should return the false value (2) | ✅ |
| Empty array is falsy, so it is returned | ✅ |
| 0 is falsy, so it is returned | ✅ |
| Empty string is falsy, so it is returned | ✅ |
| 0 as a string is truthy, so the last truthy value is returned | ✅ |
| And with no arguments should return false | ✅ |
| And with non-array arguments should throw | ❌ |
| And will not interpret the second argument if the first is false | ❌ |
| And will not interpret the second argument if the first is falsy | ❌ |
| And will not interpret the nth argument if any value before it is false | ❌ |

# ./suites/string/in.json — 8/8 passed

| Test | Result |
|------|--------|
| In operator with array finds exact match | ✅ |
| In operator with array returns false for no match | ✅ |
| In operator with string finds substring | ✅ |
| In operator with string is case sensitive | ✅ |
| In operator with string returns false for no match | ✅ |
| In operator with empty array returns false | ✅ |
| In operator with empty string search returns true | ✅ |
| In operator with empty string target returns false | ✅ |

# ./suites/arithmetic/modulo.json — 31/31 passed

| Test | Result |
|------|--------|
| Modulo | ✅ |
| Modulo (2) | ✅ |
| Modulo (3) | ✅ |
| Modulo with a Decimal Operand | ✅ |
| Modulo with Multiple Operands | ✅ |
| Modulo with Multiple Operands (2) | ✅ |
| Modulo with Negative Numbers | ✅ |
| Modulo with Strings | ✅ |
| Modulo with Booleans | ✅ |
| Modulo with Multiple Value Types | ✅ |
| Modulo with Multiple Value Types (2) | ✅ |
| Modulo with Single Operand (Number) | ✅ |
| Modulo with Single Operand, Direct (Number) | ✅ |
| Modulo with Single Operand, Direct (0) | ✅ |
| Modulo Operator with Single Operand (Number) | ✅ |
| Modulo Operator with Single Operand (Negative Number) | ✅ |
| Modulo with zero operands is an error | ✅ |
| Modulo Operator with Single Operand, Direct (Number) | ✅ |
| Modulo Operator with Single Operand, Direct (0) | ✅ |
| Modulo Operator with Single Operand (String) | ✅ |
| Modulo Operator with Single Operand, Direct (Negative Number String) | ✅ |
| Modulo Operator with Single Operand, Direct (String 0) | ✅ |
| Modulo Operator with Single Operand, Direct (true) | ✅ |
| Modulo Operator with Single Operand, Direct (false) | ✅ |
| Modulo Operator with Single Operand, Direct (Empty String) | ✅ |
| Modulo Operator with a Single Operand, Direct (null) | ✅ |
| Modulo with val | ✅ |
| Modulo with string produces NaN | ✅ |
| Modulo with array produces NaN | ✅ |
| Modulo with a negative dividend | ✅ |
| Modulo with a negative divisor | ✅ |

# ./suites/additional.json — 4/4 passed

| Test | Result |
|------|--------|
| Rule array with val | ✅ |
| If Operator fetching both condition and consequent from data | ✅ |
| Reduce Operator with val | ✅ |
| Simple Inlineable Val Chained | ✅ |

