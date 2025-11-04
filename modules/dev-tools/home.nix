{ inputs, ... }:
{
  imports = [
    ./git.nix
    ./terminal/home.nix
    ./vscode.nix
    ./charles/home.nix
    ./nix.nix
    ./unity/home.nix
    ./jetbrains.nix
    ./idapro/home.nix
  ];
}
