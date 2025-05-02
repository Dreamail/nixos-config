{
  homeModule = { };
  nixosModule =
    { inputs, ... }:
    let
      frp-token = import "${inputs.mysecrets}/frp-token.nix";
    in
    {
      services.frp = {
        enable = true;
        role = "server";
        settings = {
          auth.token = frp-token;
        };
      };
    };
}
