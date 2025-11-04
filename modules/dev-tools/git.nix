{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  git-config = import "${inputs.mysecrets}/git-config.nix";
  mkGitWrapper =
    user:
    pkgs.stdenv.mkDerivation {
      name = "git-${user}";
      src = pkgs.emptyDirectory;
      nativeBuildInputs = [ pkgs.makeWrapper ];
      installPhase = ''
        makeWrapper ${pkgs.git}/bin/git ${placeholder "out"}/bin/git-${user} \
          --set GIT_SSH_COMMAND 'ssh -i ~/.ssh/id_ed25519.${user} -o IdentitiesOnly=yes' \
          --set GIT_AUTHOR_NAME '${git-config.others.${user}.userName}' \
          --set GIT_AUTHOR_EMAIL '${git-config.others.${user}.userEmail}'
      '';
    };
  wrappedPackages = lib.forEach (lib.attrNames git-config.others) (user: mkGitWrapper user);
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = git-config.main.userName;
    userEmail = git-config.main.userEmail;
  };

  home.packages = wrappedPackages;
}
