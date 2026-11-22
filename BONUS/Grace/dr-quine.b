extrn putchar, char;

dr_quine() {
	auto i;
	auto prog;

	i = 0;
	prog = "@";
	while (char(prog, i))
	{
		putchar(char(prog, i));
		i++;
	}
}

main() {
	dr_quine();
}
