{ inputs, ... }:
let
  git-config = import "${inputs.mysecrets}/git-config.nix";
in
{
  imports = [
    ./terminal/home.nix
    ./vscode.nix
    ./charles/home.nix
    ./nix.nix
    ./unity/home.nix
    ./jetbrains.nix
    ./idapro/home.nix
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = git-config.userName;
    userEmail = git-config.userEmail;
  };
}
