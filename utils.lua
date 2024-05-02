function read_classpath(root_dir)
  local file_path = root_dir .. "/.classpath"
  local file = io.open(file_path, "r")
  if not file then
    print("file not found in " .. file_path)
    return
  end
  for line in file:lines() do
    local entry = line:match 'classpathentry kind="(lib|src)" path="(.-)"'
    if entry then
      print(entry)
    end
  end
  file:close()
end
print(read_classpath "D:/work/ybej/crafts")
