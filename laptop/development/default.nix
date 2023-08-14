{pkgs, ...}: {
  imports = [
    #./anyrun.nix
  ];

  home.packages = with pkgs; [
    vscode

  ];
  
  let
    base-python-packages = ps: with ps; [
      pandas
      seaborn
      ipykernel
      jupyter_client
    ];
  in
  environment.systemPackages = [
    (pkgs.python3.withPackages base-python-packages)
  ];
}
