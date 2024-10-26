{ pkgs, inputs, ... }: {
  home.packages = [
      inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
