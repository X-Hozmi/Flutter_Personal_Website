"""Serves the Flutter web build locally for testing.

Usage (from anywhere):
    python tool/serve_web.py [port]

Unlike `python -m http.server`, this script:
  * always serves `build/web` next to this repository, regardless of the
    current working directory, and fails loudly if the build is missing;
  * falls back to `index.html` for unknown paths, so refreshing or opening
    routes such as `/projects` works (the app uses path URL strategy).
"""

import functools
import http.server
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent / "build" / "web"
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8080


class SpaHandler(http.server.SimpleHTTPRequestHandler):
    def send_head(self):
        if not pathlib.Path(self.translate_path(self.path)).exists():
            self.path = "/index.html"
        return super().send_head()


def main() -> None:
    if not (ROOT / "index.html").is_file():
        sys.exit(f"{ROOT} not found. Run `flutter build web --release` first.")

    handler = functools.partial(SpaHandler, directory=str(ROOT))
    with http.server.ThreadingHTTPServer(("127.0.0.1", PORT), handler) as server:
        print(f"Serving {ROOT} at http://localhost:{PORT} (Ctrl+C to stop)")
        try:
            server.serve_forever()
        except KeyboardInterrupt:
            pass


if __name__ == "__main__":
    main()
