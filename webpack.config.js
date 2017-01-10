var path = require("path");

module.exports = {
  devServer: { inline: true },
  entry: { app: ["./lib/js/src/index.js"] },
  output: {
    path: path.resolve(__dirname, "build"),
    publicPath: "/assets/",
    filename: "bundle.js"
  }
};

