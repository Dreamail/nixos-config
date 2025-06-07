{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule (finalAttrs: {
  pname = "lfs-test-server";
  version = "0.4.0-513e795";

  src = fetchFromGitHub {
    owner = "git-lfs";
    repo = "lfs-test-server";
    rev = "513e795a10a1c935b45e83b134a29d8526b040eb";
    hash = "sha256-CVC7i84DqI+HQqfUvjG9Y1OZTFLveNy8Nq93vW5SpXU=";
  };

  vendorHash = "sha256-Dk5gG0EQ+2uoTnHfoZ8j+ctlB65vB9eA5JEe1rH+4mM=";

  doCheck = false;
})
