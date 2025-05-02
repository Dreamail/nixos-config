{
  homeModule = { };
  nixosModule =
    { inputs, ... }:
    let
      domain = (import "${inputs.mysecrets}/aliyun.nix").domain;
      frp-token = import "${inputs.mysecrets}/frp-token.nix";
    in
    {
      services.frp = {
        enable = true;
        role = "client";

        settings = {
          serverAddr = domain;
          serverPort = 7000;
          auth.token = frp-token;
        };
      };
    };
}
