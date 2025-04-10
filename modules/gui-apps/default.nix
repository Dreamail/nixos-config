{
  homeModule = {pkgs, ...}: {
    home.packages = with pkgs; [
      # Web Browser
      firefox

      # Chinese IMs
      (callPackage ./pkgs/qq.nix {})
      (callPackage ./pkgs/wechat.nix {})
    ];
  };
  nixosModule = {inputs, ...}: {};
}
