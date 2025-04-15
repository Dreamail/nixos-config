{
  inputs,
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.charles];

  security.pki.certificateFiles = ["${inputs.mysecrets}/charles-ca/charles-proxy-ssl-proxying-certificate.pem"];
}
