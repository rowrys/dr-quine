const prog: string = "const prog: string = \"@\"\n\nproc dr_quine(buffer: ptr string): string =\n  for i in 0..prog.len - 1:\n    if prog[i] == (char)64:\n      echo \"escaped\"\n    else:\n      buffer[].add(prog[i])\n    stdout.flushFile()\n  return buffer[]\n\nproc main() =\n  const file_name: string = \"Grace_kid.nim\"\n  var buffer: string;\n  writeFile(file_name, dr_quine(addr buffer))\n\nmain()"

proc dr_quine(buffer: ptr string): string =
  for i in 0..prog.len - 1:
    if prog[i] == (char)64:
      echo "escaped"
    else:
      buffer[].add(prog[i])
    stdout.flushFile()
  return buffer[]

proc main() =
  const file_name: string = "Grace_kid.nim"
  var buffer: string;
  writeFile(file_name, dr_quine(addr buffer))

main()