# DevContainer Image for Local/GitHub Codespaces Development

The DevContainer image provides a convenient environment for local and GitHub Codespaces development. However, please note that since it runs as a Docker container within another Docker container, it may have slower performance due to the time required for package fetching and environment preparation. Despite this, it functions as expected.

## GitHub Codespaces
To utilize this image with GitHub Codespaces, simply run the repository, and it should function correctly.

## Local Development Using Visual Studio Code

For local development with Visual Studio Code, please refer to the [official tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial). You will need to have the DevContainer extension installed.

## Compatibility with Podman
I attempted to make the DevContainer image work with Podman Desktop on Windows, but initially encountered difficulties where it failed to build. The solution involved downgrading the Podman version to `v4.3.1`, as outlined in this [GitHub issue](https://github.com/containers/podman/issues/17313#issuecomment-1508452808). However, downgrading introduced a new error: `Error: unrecognized command 'podman.exe buildx version'. Please try 'podman.exe buildx --help' for more information.`

While Podman has the capability to run DevContainers, occasional issues may arise. I will update README with a solution once it becomes available.
