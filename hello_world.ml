open Opium.Std

type person = {
  name: string;
  age: int;
}

let json_of_person { name ; age } =
  let open Ezjsonm in
  dict [ "name", (string name)
       ; "age", (int age) ]

let hello_handler req =
  `String ("Hello " ^ param req "name") |> respond'

let hello_route = get "/hello/:name" hello_handler

let person_handler req =
  let person = {
    name = param req "name";
    age = "age" |> param req |> int_of_string
  } in
  `Json (person |> json_of_person) |> respond'

let person_route = get "/person/:name/:age" person_handler

let _ =
  App.empty
  |> hello_route
  |> person_route
  |> App.run_command
