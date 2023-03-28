{
  "root": true,
  "parserOptions": {
    "ecmaVersion": 2018,
    "sourceType": "module"
  },
  "extends": [
    "eslint:recommended",
    "@thoughtbot/eslint-config"
  ],
  "env": {
    "browser": true,
  },
  "rules": {
    "no-console": "off"
  },
  "overrides": [
    {
      "files": [
        ".eslintrc.js",
        ".template-lintrc.js",
        "ember-cli-build.js",
        "testem.js",
        "blueprints/*/index.js",
        "config/**/*.js",
        "lib/*/index.js",
        "server/**/*.js"
      ],
      "parserOptions": {
        "sourceType": "script"
      },
      "env": {
        "browser": false,
        "node": true,
      },
      "plugins": ["node"],
      "rules": {}
    }
  ]
}
