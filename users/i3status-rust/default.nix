{ ... }:
{
  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
       blocks = [
      {
        block= "temperature";
      }
      {
        block = "memory";
        format = " $icon $swap_used_percents";
        format_alt = " $icon $swap_used_percents ";
      }
      {
        block = "cpu";
        interval = 1;
      }
      {
        block = "load";
        format = " $icon $1m ";
        interval = 1;
      }
      {
        block = "sound";
      }
      {
        block = "bluetooth";
        mac = "08:DF:1F:DA:4D:A6";
      }
      { 
        block = "music";
      }
      {
        block = "time";
        format = " $timestamp.datetime(f:'%a %d/%m %R') ";
        interval = 60;
      }
    ];
      };
    };
  };
  }
