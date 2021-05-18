// swift-tools-version:5.2
import PackageDescription

let package = Package(
	name: "ADAssertLayout",
	products: [
		.library(
			name: "ADAssertLayout",
			targets: ["ADAssertLayout"]),
	],
	targets: [
		.target(
			name: "ADAssertLayout",
			path: "ADAssertLayout")
	]
)
