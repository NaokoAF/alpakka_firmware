{
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	outputs = { self, nixpkgs }:
	let
		lib = nixpkgs.lib;
		systems = [ "x86_64-linux" "aarch64-linux" ];
		forAllSystems = lib.genAttrs systems;
	in
	{
		devShells = forAllSystems (system:
		let
			pkgs = import nixpkgs { inherit system; };
		in
		with pkgs;
		{
			default = mkShell {
				packages = [
					gnumake
					cmake
					python316
					git
				];
			};
		});
	};
}
