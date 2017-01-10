var path = require("path");

module.exports = {
  devServer: { inline: true },
  entry: [ "./lib/js/src/index.js" ],
  output: {
    path: path.resolve(__dirname, "build"),
    publicPath: "/assets/",
    filename: "bundle.js"
  },

  module: {
    loaders: [ { test: /\.css$/, loader: "style-loader!css-loader" } ]
  }
};

