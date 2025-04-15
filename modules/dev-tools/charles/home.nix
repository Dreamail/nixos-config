{
  inputs,
  config,
  pkgs,
  ...
}:
{
  home.file.".charles/ca/charles-proxy-ssl-proxying-certificate.cer".source =
    "${inputs.mysecrets}/charles-ca/charles-proxy-ssl-proxying-certificate.cer";
  home.file.".charles/ca/charles-proxy-ssl-proxying-certificate.pem".source =
    "${inputs.mysecrets}/charles-ca/charles-proxy-ssl-proxying-certificate.pem";
  age.secrets."keystore" = {
    file = "${inputs.mysecrets}/charles-ca/keystore.age";
    path = "${config.home.homeDirectory}/.charles/ca/keystore";
  };

  home.packages = [ pkgs.proxychains ];
}
