{lib, config, pkgs, ... }:

let
    cfg = config.main-user;
in
{
    options.main-user = {
        enable = lib.mkEnableOption "enable user module";

	username = lib.mkOption {
	    default = "mainuser";
	    description = "username";
	};
    };
    config = lib.mkIf cfg.enable {
        users.users.${cfg.username} = {
	    isNormalUser = true;
	    initialPassword = "123";
	    description = "User";
	};
    };
}
