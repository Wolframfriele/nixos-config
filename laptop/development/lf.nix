{pkgs, ...}: {

  home.packages = with pkgs; [
    bat
    p7zip
  ];

  programs.lf = {
    enable = true;
  };
  programs.pistol = {
    enable = true;
    associations = [
      {
        mime = "application/json";
        command = "${pkgs.bat}/bin/bat %pistol-filename%";
      }
      {
        fpath = ".*.md$";
        command = "${pkgs.bat}/bin/bat %pistol-filename%";
      }
      {
        fpath = ".*.tar$";
        command = "tar tf %pistol-filename%";
      }
      {
        fpath = ".*.tar.gz$";
        command = "tar tf %pistol-filename%";
      }
      {
        mime = "application/zip";
        command = "${pkgs.p7zip}/bin/7z l %pistol-filename%";
      }
      {
        mime = "application/java-archive";
        command = "${pkgs.p7zip}/bin/7z l %pistol-filename%";
      }
      {
        mime = "application/vnd.rar";
        command = "${pkgs.p7zip}/bin/7z l %pistol-filename%";
      }
      {
        mime = "application/x-7z-compressed";
        command = "${pkgs.p7zip}/bin/7z l %pistol-filename%";
      }
    ];
  };
}
