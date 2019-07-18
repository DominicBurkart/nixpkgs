{ callPackage, makeFontsConf, gnome2 }:

let
  mkStudio = opts: callPackage (import ./common.nix opts) {
    fontsConf = makeFontsConf {
      fontDirectories = [];
    };
    inherit (gnome2) GConf gnome_vfs;
  };
  stableVersion = {
    version = "3.4.2.0"; # "Android Studio 3.4.2"
    build = "183.5692245";
    sha256Hash = "090rc307mfm0yw4h592l9307lq4aas8zq0ci49csn6kxhds8rsrm";
  };
  betaVersion = {
    version = "3.5.0.20"; # "Android Studio 3.5 RC 3"
    build = "191.5781497";
    sha256Hash = "03c5f01dqjvz55l8vyrpypjmmip96kc27p8sw0c5jky0igiyym5j";
  };
  latestVersion = { # canary & dev
    version = "3.6.0.5"; # "Android Studio 3.6 Canary 5"
    build = "191.5721125";
    sha256Hash = "05y7xw6gqiwp7iphm9p61vxwc7cwddighrj1h2pp2r96csb3pmww";
  };
in rec {
  # Attributes are named by their corresponding release channels

  stable = mkStudio (stableVersion // {
    channel = "stable";
    pname = "android-studio";
  });

  beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });

  dev = mkStudio (latestVersion // {
    channel = "dev";
    pname = "android-studio-dev";
  });

  canary = mkStudio (latestVersion // {
    channel = "canary";
    pname = "android-studio-canary";
  });
}
