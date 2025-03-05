// tailwind.config.js
module.exports = {
    content: [
      "./app/views/**/*.{html.erb}",   // ビューのパス
      "./app/assets/stylesheets/**/*.{css,scss}", // スタイルシートのパス
      "./app/javascript/**/*.js",       // JavaScriptのパス（必要な場合）
    ],
    theme: {
      extend: {},
    },
    plugins: [],
  }