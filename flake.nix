{
  description = "C# プロフェッショナル学習教材（Web → AR/VR）";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          dotnet-sdk_10
          # Web 編 第12章（Next.js 連携）で使う
          nodejs_24
          # AR/VR 編で Quest・Android 実機のログ確認やアプリ転送に使う
          android-tools
        ];

        # dotnet CLI のテレメトリと初回メッセージを抑止する
        DOTNET_CLI_TELEMETRY_OPTOUT = "1";
        DOTNET_NOLOGO = "1";
        # ビルド成果物（apphost）を直接起動できるよう、ランタイムの場所を教える
        DOTNET_ROOT = "${pkgs.dotnet-sdk_10.unwrapped}/share/dotnet";
      };
    };
}