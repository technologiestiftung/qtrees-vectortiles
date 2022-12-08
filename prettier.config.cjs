module.exports = {
	semi: true,
	singleQuote: false,
	trailingComma: "all",
	useTabs: true,
	overrides: [
		{
			files: ["*.yaml", "*.yml"],
			options: {
				tabWidth: 2,
				singleQuote: true,
			},
		},
	],
};
