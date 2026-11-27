const PROG: &str = "const PROG: &str = \"@\";\nconst SULLY: i8 = 5 ;\n\nfn dr_quine() -> Vec<u8> {\n    let mut dec_sully: bool = false;\n    let mut buffer: Vec<u8> = PROG.as_bytes().to_vec();\n    let idx_magic_char: usize = buffer\n        .iter()\n        .position(|&x| x == 64)\n        .expect(\"the programme do not contain the magic char \'@\'\");\n    buffer.splice(\n        idx_magic_char..idx_magic_char + 1,\n        buffer.clone().escape_ascii(),\n    );\n    for i in 0..buffer.len() {\n        if buffer[i] == \'5\' as u8 && buffer[i + 1] == \' \' as u8 && buffer[i + 2] == \';\' as u8 {\n            if dec_sully {\n                if SULLY == 0 {\n                    buffer[i] = \'-\' as u8;\n                    buffer.insert(i + 1, \'1\' as u8);\n                }\n                else {\n                    buffer[i] = SULLY.saturating_add(-1) as u8 + \'0\' as u8;\n                }\n            }\n            dec_sully = true;\n        }\n    }\n    buffer\n}\n\nfn main() {\n    let file_number = SULLY;\n    let file_name = \"Sully_X.rs\".replace(\"X\", &file_number.to_string());\n    let buffer;\n    let cmd: String = String::from(\"rustc Sully_X.rs -o Sully_X && ./Sully_X\").replace(\"X\", &file_number.to_string());\n\n    if SULLY < 0 {\n        return;\n    }\n    buffer = dr_quine();\n    std::fs::write(file_name, buffer).unwrap();\n    std::process::Command::new(\"sh\")\n        .arg(\"-c\")\n        .arg(cmd)\n        .output()\n        .unwrap();\n    return;\n}\n";
const SULLY: i8 = 5 ;

fn dr_quine() -> Vec<u8> {
    let mut dec_sully: bool = false;
    let mut buffer: Vec<u8> = PROG.as_bytes().to_vec();
    let idx_magic_char: usize = buffer
        .iter()
        .position(|&x| x == 64)
        .expect("the programme do not contain the magic char '@'");
    buffer.splice(
        idx_magic_char..idx_magic_char + 1,
        buffer.clone().escape_ascii(),
    );
    for i in 0..buffer.len() {
        if buffer[i] == '5' as u8 && buffer[i + 1] == ' ' as u8 && buffer[i + 2] == ';' as u8 {
            if dec_sully {
                if SULLY == 0 {
                    buffer[i] = '-' as u8;
                    buffer.insert(i + 1, '1' as u8);
                }
                else {
                    buffer[i] = SULLY.saturating_add(-1) as u8 + '0' as u8;
                }
            }
            dec_sully = true;
        }
    }
    buffer
}

fn main() {
    let file_number = SULLY;
    let file_name = "Sully_X.rs".replace("X", &file_number.to_string());
    let buffer;
    let cmd: String = String::from("rustc Sully_X.rs -o Sully_X && ./Sully_X").replace("X", &file_number.to_string());

    if SULLY < 0 {
        return;
    }
    buffer = dr_quine();
    std::fs::write(file_name, buffer).unwrap();
    std::process::Command::new("sh")
        .arg("-c")
        .arg(cmd)
        .output()
        .unwrap();
    return;
}
