{ pkgs, ... }:{

  home.packages = [
    (pkgs.python311.withPackages (p: with p; [
      ipython # interactive shell
      jupyter # interactive notebooks
      matplotlib # plots
      numpy # numerical computation
      pandas # data analysis
      seaborn
      # ipykernel
      # jupyter_client
    ]))
  ];
}
