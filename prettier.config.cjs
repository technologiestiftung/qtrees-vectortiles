module.exports = {
	semi: true,
	singleQuote: false,
	trailingComma: 'all',
	overrides: [
		{
			files: ['*.yaml', '*.yml'],
			options: {
				tabWidth: 4,
				singleQuote: true,
			},
		},
	],
};
