// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")
const colors = require('tailwindcss/colors')

module.exports = {
	content: [
		"./js/**/*.js",
		"../lib/live_budget_web.ex",
		"../lib/live_budget_web/**/*.*ex",
		"./node_modules/flowbite/**/*.js"
	],
	// make sure to safelist these classes when using purge
	safelist: [
		'w-64',
		'w-1/2',
		'rounded-l-lg',
		'rounded-r-lg',
		'bg-gray-200',
		'grid-cols-4',
		'grid-cols-7',
		'h-6',
		'leading-6',
		'h-9',
		'leading-9',
		'shadow-lg'
	],
	// enable dark mode via class strategy
	darkMode: 'class',
	theme: {
		fontFamily: {
			body: [
				"Nunito Sans",
				"ui-sans-serif",
				"system-ui",
				"-apple-system",
				"system-ui",
				"Segoe UI",
				"Roboto",
				"Helvetica Neue",
				"Arial",
				"Noto Sans",
				"sans-serif",
				"Apple Color Emoji",
				"Segoe UI Emoji",
				"Segoe UI Symbol",
				"Noto Color Emoji",
			],
			sans: [
				"Nunito Sans",
				"ui-sans-serif",
				"system-ui",
				"-apple-system",
				"system-ui",
				"Segoe UI",
				"Roboto",
				"Helvetica Neue",
				"Arial",
				"Noto Sans",
				"sans-serif",
				"Apple Color Emoji",
				"Segoe UI Emoji",
				"Segoe UI Symbol",
				"Noto Color Emoji",
			],
		},
		container: {
			center: true,
			padding: "1rem",
		},
		colors: {
			transparent: "transparent",
			current: "currentColor",
			black: "#000",
			white: "#fff",
			primary: {
				100: "#d1fae5",
				200: "#a7f3d0",
				300: "#6ee7b7",
				400: "#34d399",
				500: "#10b981",
				600: "#059669",
				700: "#047857",
				800: "#065f46",
				900: "#064e3b",
			},
			secondary: {
				100: "#fff8e8",
				200: "#fef1d7",
				300: "#fdeac7",
				400: "#fbe3b6",
				500: "#fadca5",
				600: "#f9d19b",
				700: "#f6ba87",
				800: "#f5af7d",
				900: "#b57446",
			},
			neutral: {
				100: "#ffffff",
				200: "#f6f6f5",
				300: "#ebebea",
				400: "#e4e4e2",
				500: "#8e8c88",
				600: "#73716c",
				700: "#5a5752",
				800: "#413e38",
				900: "#000000",
			},
			error: {
				100: "#ffeeee",
				300: "#f68d8d",
				500: "#d63232",
				900: "#790909",
			},
			warning: {
				100: "#fef3d7",
				300: "#fdd980",
				500: "#fcb603",
				900: "#9e7203",
			},
			success: {
				100: "#aceec6",
				300: "#66e197",
				500: "#26b34d",
				900: "#18502a",
			},
			info: {
				100: "#bbc9f8",
				300: "#849beb",
				500: "#3e62e3",
				900: "#15286a",
			},
		},
		extend: {},
	},
	plugins: [
		require("@tailwindcss/forms"),
		// Allows prefixing tailwind classes with LiveView classes to add rules
		// only when LiveView classes are applied, for example:
		//
		//     <div class="phx-click-loading:animate-ping">
		//
		plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
		plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
		plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

		// Embeds Heroicons (https://heroicons.com) into your app.css bundle
		// See your `CoreComponents.icon/1` for more information.
		//
		plugin(function ({ matchComponents, theme }) {
			let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
			let values = {}
			let icons = [
				["", "/24/outline"],
				["-solid", "/24/solid"],
				["-mini", "/20/solid"],
				["-micro", "/16/solid"]
			]
			icons.forEach(([suffix, dir]) => {
				fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
					let name = path.basename(file, ".svg") + suffix
					values[name] = { name, fullPath: path.join(iconsDir, dir, file) }
				})
			})
			matchComponents({
				"hero": ({ name, fullPath }) => {
					let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
					let size = theme("spacing.6")
					if (name.endsWith("-mini")) {
						size = theme("spacing.5")
					} else if (name.endsWith("-micro")) {
						size = theme("spacing.4")
					}
					return {
						[`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
						"-webkit-mask": `var(--hero-${name})`,
						"mask": `var(--hero-${name})`,
						"mask-repeat": "no-repeat",
						"background-color": "currentColor",
						"vertical-align": "middle",
						"display": "inline-block",
						"width": size,
						"height": size
					}
				}
			}, { values })
		}),
		require('flowbite/plugin')({
			charts: true,
			forms: true,
			tooltips: true
		}),
	]
}
