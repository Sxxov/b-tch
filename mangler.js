const readline = require('readline');
const rl = readline.createInterface({
	input: process.stdin,
	output: process.stdout,
	terminal: false
});

let lines = [];
let result = '';

console.log('Paste your code and press enter twice to mangle.');
console.log('Input code may be prefixed with `@REM` (it will be sliced and parsed as normal).');

rl.on('line', (line) => {
	if (line === ''
		&& lines[lines.length - 1] === '') {
		rl.close();

		return;
	}

    lines.push(line);
});

rl.on('close', (cmd) => {
	lines = lines.filter((line) => !!line);

	let i = -1;
	for (let line of lines) {
		++i;
		// remove @REM to not need to uncomment src lines
		// todo: might be problematic
		line = line.replace(/^@REM/, '');

		// housekeeping
		line = line.trim();
		line = line.replace(/\t/g, '');

		if (line.toLowerCase().indexOf('rem') === 0) {
			lines[i] = '';

			continue;
		}

		// escape
		line = line.replace(/\!/g, '^^^!');
		line = line.replace(/>/g, '^^^>');

		// remove &&'s of previous line if not valid for current line
		const previousLine = lines[i - 1] ?? '';
		// console.log(line.indexOf(')'), previousLine.slice(-2));
		if (line.indexOf(')') === 0
			&& previousLine.slice(-1) === '&') {
			lines[i - 1] = previousLine.substr(0, previousLine.length - 1);
		}

		// add &&'s to current line
		// console.log(`"${line}"`, i, lines.length);
		if (line[line.length - 1] !== '('
			&& line !== ''
			&& i !== lines.length - 1) {
			line += '&';
		}

		lines[i] = line;
	}

	result = lines.join('');
	
	const forParts = result.split('for ');
	let nextPartRequiresFix = false;

	forParts.forEach((forPart, i) => {
		if (i === forParts.length - 1) {
			return;
		}

		forPart = forPart.trim();

		if (nextPartRequiresFix) {
			nextPartRequiresFix = false;

			let scope = 0;

			for (const {i, char} of Object.entries(forPart.split(''))) {
				if (char === '(') {
					++scope;
				}

				if (char === ')') {
					--scope;

					if (scope === 0) {
						forPart = `${
							forPart.slice(0, i)
						})${
							forPart.slice(i + 1)
						}`;
						break;
					}
				}
			}
				
		}

		if (forPart[forPart.length - 1] !== '(') {
			console.warn('Unencapsulated for loop detected, attempting to fix!');

			forPart += '(';

			nextPartRequiresFix = true;
		}
	});

	result = forParts.join('for ');

	const ifParts = result.split('if ');

	ifParts.forEach((ifPart, i) => {
		if (i === 0) {
			return;
		}

		const indexOfAndAnd = ifPart.indexOf('&');
		const indexOfWrongAndAnd = ifPart.indexOf('&(');

		if (indexOfAndAnd === indexOfWrongAndAnd) {
			ifParts[i] = ifPart.replace('&(', ' (');
		}
	});

	result = ifParts.join('if ');

	console.log(result);
});