{ pkgs, ... }: {
  imports = [
    ./pkg-docker.nix
  ];

  virtualisation.oci-containers.containers.mssql = {
    image = "mcr.microsoft.com/mssql/server:2022-latest";
    ports = [ "1433:1433" ];
    autoStart = false;
    
    environment = {
      ACCEPT_EULA = "Y";
      MSSQL_PID = "Developer";
    };
    
    environmentFiles = [ "/root/secrets/mssql.env" ];
    
    volumes = [
      "mssql-data:/var/opt/mssql"
    ];
  };

  environment.systemPackages = with pkgs; [
    sqlcmd
  ];
}
