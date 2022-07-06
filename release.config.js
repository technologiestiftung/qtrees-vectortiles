module.exports = {
  branches: [
    { name: "main" }
  ],
  npmPublish: false,
  dryRun: false,
  plugins: [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    "@semantic-release/changelog",
    "@semantic-release/git",
    "@semantic-release/github",
    "@semantic-release/release-notes-generator",
  ],
};
