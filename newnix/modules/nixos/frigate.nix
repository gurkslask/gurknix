{ config, lib,  ... }:

let
  cfg = config.services.myfrigate;
in
{
  options.services.myfrigate = with lib; {
    enable = mkEnableOption "frigate";

    hostname = lib.mkOption {
      type = lib.types.str;
      default = "localhost"; 
    };
  };

  config = lib.mkIf cfg.enable {
    services.frigate = {
      enable = cfg.enable;
      hostname = cfg.hostname;
      settings = {
        # Använd OpenVINO för att köra detektering på iGPU:n
        detectors = {
          ov = {
            type = "openvino";
            device = "AUTO"; # Använder iGPU:n för detektering
          };
        };
        model = {
          width = 300;
          height = 300;
          input_tensor = "nhwc";
          input_pixel_format = "bgr";
          path = "/openvino-model/ssdlite_mobilenet_v2.xml";
          labelmap_path = "/openvino-model/coco_91cl_bkgr.txt";
        };

        # Globala inställningar för hårdvaruacceleration (ffmpeg)
        ffmpeg = {
          hwaccel_args = [
            "preset-vaapi"
            # "-hwaccel" "vaapi"
            # "-hwaccel_device" "/dev/dri/renderD128"
            # "-hwaccel_output_format" "vaapi"
          ];
        };
        # Settings for recording
        record = {
          enabled = true;
          retain = {
            days = 2;
            mode = "all";
          };
        };
        # Settings for camera(s)
        cameras."test1" = {
          detect = {
            enabled = true;
          };
          ffmpeg.inputs = [ {
            path = "rtsp://alex:Minne2025@192.168.20.220:554";
            input_args = "preset-rtsp-restream";
            roles = [ "record" "detect"];
          } ];
        };
      };
    };
  };
  
}

