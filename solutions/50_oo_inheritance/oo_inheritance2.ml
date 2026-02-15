class account initial = object
  val mutable balance = initial

  method balance = balance

  method deposit amount =
    if amount < 0.0 then invalid_arg "negative deposit";
    balance <- balance +. amount

  method withdraw amount =
    if amount < 0.0 then invalid_arg "negative withdraw";
    if amount > balance then false
    else (
      balance <- balance -. amount;
      true)
end

class fee_account fee initial = object
  inherit account initial as super

  method! withdraw amount =
    super#withdraw (amount +. fee)
end

let () =
  let a = new fee_account 1.0 10.0 in
  assert (a#withdraw 3.0);
  assert (a#balance = 6.0);
  assert (not (a#withdraw 10.0));
  assert (a#balance = 6.0);
  print_endline "OO override with super works!"
