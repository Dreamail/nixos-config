{
  pkgs,
  user,
  ...
}:
{
  users.users.${user.name} = {
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
}
