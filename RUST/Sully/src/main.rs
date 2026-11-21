const PROG: &str = "const PROG: &str = \"@\";\nconst SULLY: u8 = 5;\n\nfn dr_quine() -> Vec<u8> {\n\tlet mut buffer: Vec<u8> = PROG.as_bytes().to_vec();\n\tlet idx_magic_char: usize = buffer.iter().position(|&x| x == 64).expect(\"the programme do not contain the magic char \'@\'\");\n\tbuffer.splice(idx_magic_char..idx_magic_char + 1, buffer.clone().escape_ascii());\n\tbuffer\n}\n\nfn main() {\n\tif SULLY == 0 {\n\t\treturn ;\n\t}\n\tlet buffer = dr_quine();\n\tstd::fs::write(\"out.rs\", buffer).unwrap();\n\treturn ;\n}\n";
const SULLY: u8 = 5;

fn dr_quine() -> Vec<u8> {
	let mut buffer: Vec<u8> = PROG.as_bytes().to_vec();
	let idx_magic_char: usize = buffer.iter().position(|&x| x == 64).expect("the programme do not contain the magic char '@'");
	buffer.splice(idx_magic_char..idx_magic_char + 1, buffer.clone().escape_ascii());
	buffer
}

fn main() {
	if SULLY == 0 {
		return ;
	}
	let buffer = dr_quine();
	std::fs::write("out.rs", buffer).unwrap();
	return ;
}
