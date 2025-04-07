{inputs, ...}: let
  git-config = import "${inputs.mysecrets}/git-config.nix";
in {
  imports = [
    ./vscode.nix
  ];

  programs.git = {
    enable = true;
    userName = git-config.userName;
    userEmail = git-config.userEmail;
  };
}
