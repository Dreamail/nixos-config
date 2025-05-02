pkgs: rec {
  knd-136-after = pkgs.fetchurl {
    url = "https://static.wikia.nocookie.net/projectsekai/images/8/8c/Ceremony_In_The_Classroom_T.png/revision/latest";
    sha256 = "LkRbGfnoDFhW+K5b3PlDHb9DSarlcitkixSDSTxfMz4=";
  };
  knd-206-after = pkgs.fetchurl {
    url = "https://static.wikia.nocookie.net/projectsekai/images/1/13/A_Room_That's_Empty_Now_T.png/revision/latest";
    sha256 = "gFBF8+S/KKFL/OE7bYejwLt+oMYqn1AD+KMPrGD/6u4=";
  };
  paper = knd-206-after;
}
