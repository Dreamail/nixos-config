{ inputs, ... }:
let
  git-config = import "${inputs.mysecrets}/git-config.nix";
in
{
  imports = [
    ./terminal/home.nix
    ./vscode.nix
    ./charles/home.nix
  ];

  programs.git = {
    enable = true;
    userName = git-config.userName;
    userEmail = git-config.userEmail;
  };
}
