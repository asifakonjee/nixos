self: super: {
  openbangla-keyboard = super.fcitx5-openbangla-keyboard.overrideAttrs (old: {
    version = "develop-2023-11-05";
    src = self.fetchFromGitHub {
      owner = "asifakonjee";
      repo = "openbangla-keyboard";
      rev = "73012424cfb4db310250836e63cd87ac84106c1b";
      hash = "sha256-3moWzvuCD952sJGQct97k3Ls05S1ZavWhtH4LEdjUTI=";
      fetchSubmodules = true;
    };
    patches = [];  # Empty list to prevent applying any patches
  });
}
