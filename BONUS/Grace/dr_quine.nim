const prog: string = "const prog: string = \"@\"\n\nmacro unused(): untyped =\n  echo \"Nim is interesting in this exercise cause you can execute code at compile time with a macro.\"\n\nmacro unused_realy(): untyped =\n  # A comment btw\n  echo \"the sky is blue\"\n\nmacro dr_quine(): untyped =\n  var buffer: string;\n  for i in 0..prog.len - 1:\n    if prog[i] == (char)64:\n      for j in 0..prog.len - 1:\n        case prog[j]:\n          of '\\n':\n            buffer.add('\\\\')\n            buffer.add('n')\n          of '\\\"':\n            buffer.add('\\\\')\n            buffer.add('\\\"')\n          of '\\\\':\n            buffer.add('\\\\')\n            buffer.add('\\\\')\n          else:\n            buffer.add(prog[j])\n    else:\n      buffer.add(prog[i])\n    writeFile(\"Grace_kid.nim\", buffer)\n\ndr_quine\nunused"

macro unused(): untyped =
  echo "Nim is interesting in this exercise cause you can execute code at compile time with a macro."

macro unused_realy(): untyped =
  # A comment btw
  echo "the sky is blue"

macro dr_quine(): untyped =
  var buffer: string;
  for i in 0..prog.len - 1:
    if prog[i] == (char)64:
      for j in 0..prog.len - 1:
        case prog[j]:
          of '\n':
            buffer.add('\\')
            buffer.add('n')
          of '\"':
            buffer.add('\\')
            buffer.add('\"')
          of '\\':
            buffer.add('\\')
            buffer.add('\\')
          else:
            buffer.add(prog[j])
    else:
      buffer.add(prog[i])
    writeFile("Grace_kid.nim", buffer)

dr_quine
unused