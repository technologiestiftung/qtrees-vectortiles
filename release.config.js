module.exports = {
	branches: [{ name: "main" }],
	npmPublish: false,
	dryRun: false,
	plugins: [
		[
			"@semantic-release/commit-analyzer",
			{
				preset: "angular",
				releaseRules: [{ type: "nightly", release: "patch" }],
			},
		],
		"@semantic-release/release-notes-generator",
		"@semantic-release/changelog",
		"@semantic-release/npm",
		"@semantic-release/git",
		"@semantic-release/github",
		"@semantic-release/release-notes-generator",
	],
};
