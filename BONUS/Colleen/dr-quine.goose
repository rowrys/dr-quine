extern fn write(fd: i32, buf: const u8&, count: u64) -> i64;

const PROG: const u8[:] = "extern fn write(fd: i32, buf: const u8&, count: u64) -> i64;\n\nconst PROG: const u8[:] = \"@\";\n\nfn dr_quine() -> u8 {\n\tvar prog_escape: u8[>..] = \"\";\n\tvar idx: u64 = 0;\n\tfor i: u64 in 0..PROG.len as u64 {\n\t\tif (idx == 0 && PROG[i] == 64) {\n\t\t\twrite(1, PROG[0], i);\n\t\t\tidx = i;\n\t\t}\n\t\tmatch PROG[i] {\n\t\t\t'\\n' => {prog_escape.push('\\\\'); prog_escape.push('n')},\n\t\t\t'\\\"' => {prog_escape.push('\\\\'); prog_escape.push('\"')},\n\t\t\t'\\\\' => {prog_escape.push('\\\\'); prog_escape.push('\\\\');},\n\t\t\t'\\t' => {prog_escape.push('\\\\'); prog_escape.push('t');},\n\t\t\t_ => prog_escape.push(PROG[i]),\n\t\t}\n\t}\n\twrite(1, prog_escape[0], (prog_escape.len) as u64);\n\twrite(1, PROG[idx + 1], PROG.len as u64 - 1 - idx);\n\treturn (0);\n}\n\nfn main() {\n\tdr_quine();\n}\n";

fn dr_quine() -> u8 {
	var prog_escape: u8[>..] = "";
	var idx: u64 = 0;
	for i: u64 in 0..PROG.len as u64 {
		if (idx == 0 && PROG[i] == 64) {
			write(1, PROG[0], i);
			idx = i;
		}
		match PROG[i] {
			'\n' => {prog_escape.push('\\'); prog_escape.push('n')},
			'\"' => {prog_escape.push('\\'); prog_escape.push('"')},
			'\\' => {prog_escape.push('\\'); prog_escape.push('\\');},
			'\t' => {prog_escape.push('\\'); prog_escape.push('t');},
			_ => prog_escape.push(PROG[i]),
		}
	}
	write(1, prog_escape[0], (prog_escape.len) as u64);
	write(1, PROG[idx + 1], PROG.len as u64 - 1 - idx);
	return (0);
}

fn main() {
	dr_quine();
}
