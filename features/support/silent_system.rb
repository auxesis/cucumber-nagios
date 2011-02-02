def silent_system(cmd)
  silent_cmd = cmd + " > /dev/null 2>&1"
  system(silent_cmd)
end
