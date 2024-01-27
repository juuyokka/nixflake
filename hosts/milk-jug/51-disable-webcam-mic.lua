rule = {
  matches = {
    {
      { "node.name", "equals", "alsa_input.usb-046d_HD_Pro_Webcam_C920_ED4FC72F-02.analog-stereo" },
    },
  },
  apply_properties = {
    ["node.disabled"] = true,
  },
}

table.insert(alsa_monitor.rules,rule)
